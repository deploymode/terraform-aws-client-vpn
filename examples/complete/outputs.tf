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
  value       = module.vpn.vpn_config_path
}

output "private_subnet_ids" {
  description = "Private subnet IDs"
  value       = module.subnets.private_subnet_ids
}

output "public_subnet_ids" {
  description = "Public subnet IDs"
  value       = module.subnets.public_subnet_ids
}

output "public_subnet_cidrs" {
  description = "CIDR blocks of the created public subnets"
  value       = module.subnets.public_subnet_cidrs
}

output "private_subnet_cidrs" {
  description = "CIDR blocks of the created private subnets"
  value       = module.subnets.private_subnet_cidrs
}

output "public_route_table_ids" {
  description = "IDs of the created public route tables"
  value       = module.subnets.public_route_table_ids
}

output "private_route_table_ids" {
  description = "IDs of the created private route tables"
  value       = module.subnets.private_route_table_ids
}
