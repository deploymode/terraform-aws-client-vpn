// Networking

variable "availability_zones" {
  type = list(string)
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR block"
}

variable "vpn_client_cidr" {
  type        = string
  description = "Network CIDR for allocating IPs to VPN clients"
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
  description = "Certificate domain suffix"
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
