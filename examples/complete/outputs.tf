output "vpn_endpoint_id" {
  description = "The ID of the Client VPN endpoint."
  value       = module.vpn.id
}

output "vpn_endpoint_arn" {
  description = "The ARN of the Client VPN endpoint."
  value       = module.vpn.arn
}

output "vpn_endpoint_dns_name" {
  description = "The DNS name to be used by clients when establishing their VPN session."
  value       = module.vpn.dns_name
}

output "vpn_endpoint_status" {
  description = "The current state of the Client VPN endpoint."
  value       = module.vpn.status
}

output "vpn_config_path" {
	description = "Path to downloaded VPN config file"
	value = module.vpn.vpn_config_path
}
