// Network

variable "vpn_client_cidr" {
  type        = string
  description = "Network CIDR for allocating IPs to VPN clients"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet ID to associate clients"
}

variable "allowed_ingress_network_cidr" {
  type        = string
  description = "CIDR to which VPC clients are allowed access"
  default     = "0.0.0.0/0"
}

// Authentication

variable "cert_dir" {
  type        = string
  description = "Local storage location for generated certs. Relative to module root."
  default     = "certs"
}

variable "config_dir" {
  type        = string
  description = "Local storage location for downloaded VPN config. Relative to module root."
  default     = "config"
}

variable "cert_domain" {
  type        = string
  description = "Domain suffix for certificates"
}

// CloudWatch Logs

variable "logging_enabled" {
  type        = bool
  description = "Enable CloudWatch logging"
  default     = false
}

variable "cloudwatch_log_retention_days" {
  type        = number
  description = "Retention in days for CloudWatch Log Group"
  default     = 30
}
