variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "hosted_zone_id" {
  description = "Public Route53 Hosted Zone ID for mallhive.com"
  type        = string
}

variable "private_zone_name" {
  description = "Private Route53 hosted zone name for backend"
  type        = string
  default     = "internal.mallhive.com"
}
