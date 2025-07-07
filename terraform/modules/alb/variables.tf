variable "vpc_id" {
  description = "VPC where the ALB resides"
  type        = string
}

variable "private_subnet_1a_id" {
  description = "Private subnet ID in AZ 1a for the ALB"
  type        = string
}

variable "private_subnet_1b_id" {
  description = "Private subnet ID in AZ 1b for the ALB"
  type        = string
}

variable "security_group_ids" {
  description = "Security groups for the ALB"
  type        = list(string)
}

variable "private_zone_id" {
  description = "Route 53 private hosted zone ID for backend services"
  type        = string
}

variable "backend_record_fqdn" {
  description = "DNS record name (e.g. api.mallhive.internal)"
  type        = string
}
