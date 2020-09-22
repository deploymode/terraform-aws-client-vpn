namespace = "eg"

environment = "aps2"

stage = "test"

name = "example"

cert_domain = "example.com"

cert_dir = "../../certs"

config_dir = "../../config"

availability_zones = [
  "ap-southeast-2a"
]

vpc_cidr = "172.16.0.0/16"

vpn_client_cidr = "10.239.0.0/22"

logging_enabled = true

cloudwatch_log_retention_days = 7
