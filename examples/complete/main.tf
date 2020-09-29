module "vpc" {
  source = "git::https://github.com/cloudposse/terraform-aws-vpc.git?ref=tags/0.17.0"

  context = module.this.context

  cidr_block = var.vpc_cidr
}

module "subnets" {
  source             = "git::https://github.com/cloudposse/terraform-aws-dynamic-subnets.git?ref=tags/0.30.0"
  availability_zones = var.availability_zones

  context = module.this.context

  vpc_id               = module.vpc.vpc_id
  igw_id               = module.vpc.igw_id
  cidr_block           = module.vpc.vpc_cidr_block
  nat_gateway_enabled  = false
  nat_instance_enabled = false
}

locals {
  vpn_subnet_cidr = module.vpc.vpc_cidr_block != "" ? cidrsubnet(module.vpc.vpc_cidr_block, 6, 10) : ""
}

resource aws_subnet vpn {
  vpc_id     = module.vpc.vpc_id
  cidr_block = local.vpn_subnet_cidr

  tags = {
    Name = module.this.id
  }
}

resource aws_security_group vpn {
  name = module.this.id
  description = "Security group to apply to VPN's target network"

  ingress {
    description = "Allow all ingress"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all egress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

// VPN
module vpn {
  source = "../.."

  context = module.this.context

  vpn_client_cidr               = var.vpn_client_cidr
  cert_dir                      = var.cert_dir
  config_dir                    = var.config_dir
  cert_domain                   = var.cert_domain
  subnet_ids                    = [aws_subnet.vpn.id]
  security_groups = [aws_security_group.vpn.id]
  logging_enabled               = var.logging_enabled
  cloudwatch_log_retention_days = var.cloudwatch_log_retention_days
}
