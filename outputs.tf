output "id" {
  description = "The ID of the Client VPN endpoint."
  value       = aws_ec2_client_vpn_endpoint.default.id
}

output "arn" {
  description = "The ARN of the Client VPN endpoint."
  value       = aws_ec2_client_vpn_endpoint.default.arn
}

output "dns_name" {
  description = "The DNS name to be used by clients when establishing their VPN session."
  value       = aws_ec2_client_vpn_endpoint.default.dns_name
}

output "status" {
  description = "The current state of the Client VPN endpoint."
  value       = aws_ec2_client_vpn_endpoint.default.status
}

output "vpn_config_path" {
  description = "Path to downloaded VPN config file"
  value       = local.vpn_config_path
}
