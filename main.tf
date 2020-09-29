locals {
  vpn_config_path = "${path.root}/${var.config_dir}/client-config.ovpn"
}

// Certs
// Assume scripts/gen-certs.sh has been run
resource aws_acm_certificate client {
  private_key       = file("${path.root}/${var.cert_dir}/client1.${var.cert_domain}.key")
  certificate_body  = file("${path.root}/${var.cert_dir}/client1.${var.cert_domain}.crt")
  certificate_chain = file("${path.root}/${var.cert_dir}/ca.crt")
}

resource aws_acm_certificate server {
  private_key       = file("${path.root}/${var.cert_dir}/server.key")
  certificate_body  = file("${path.root}/${var.cert_dir}/server.crt")
  certificate_chain = file("${path.root}/${var.cert_dir}/ca.crt")
}

resource aws_cloudwatch_log_group default {
  name              = format("/aws/vpn/%s/logs", module.this.id)
  retention_in_days = var.cloudwatch_log_retention_days
}

resource aws_cloudwatch_log_stream default {
  name           = module.this.id
  log_group_name = aws_cloudwatch_log_group.default.name
}

resource aws_ec2_client_vpn_endpoint default {
  description            = module.this.id
  server_certificate_arn = aws_acm_certificate.server.arn
  client_cidr_block      = var.vpn_client_cidr

  authentication_options {
    type                       = "certificate-authentication"
    root_certificate_chain_arn = aws_acm_certificate.client.arn
  }

  connection_log_options {
    enabled               = var.logging_enabled
    cloudwatch_log_group  = aws_cloudwatch_log_group.default.name
    cloudwatch_log_stream = aws_cloudwatch_log_stream.default.name
  }

  tags = module.this.tags
}

resource aws_ec2_client_vpn_network_association default {
  for_each               = toset(var.subnet_ids)
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.default.id
  subnet_id              = each.key
  security_groups        = var.security_groups
}

resource aws_ec2_client_vpn_authorization_rule ingress-all {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.default.id
  target_network_cidr    = var.allowed_ingress_network_cidr
  authorize_all_groups   = true
  description            = "Allow all VPN groups access to ${var.allowed_ingress_network_cidr}"
}

data "aws_region" "current" {}

# 'Borrowed' from: https://github.com/achuchulev/terraform-aws-client-vpn-endpoint/blob/master/main.tf
resource null_resource export-client-config {
  provisioner local-exec {
    command = "mkdir -p ${var.config_dir} && aws --region ${data.aws_region.current.name} ec2 export-client-vpn-client-configuration --client-vpn-endpoint-id ${aws_ec2_client_vpn_endpoint.default.id} --output text > ${local.vpn_config_path}"
  }

  depends_on = [
    aws_ec2_client_vpn_network_association.default
  ]
}

resource null_resource append-client-config-certs {
  provisioner local-exec {
    command = "${path.module}/scripts/client-append-cert.sh ${path.root} ${var.cert_dir} ${var.config_dir} ${var.cert_domain}"
  }

  depends_on = [null_resource.export-client-config]
}
