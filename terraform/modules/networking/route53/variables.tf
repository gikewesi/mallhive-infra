variable "cloudfront_domain_name" {
  description = "CloudFront distribution domain name (e.g., abc123.cloudfront.net)"
  type        = string
}

variable "cloudfront_zone_id" {
  description = "CloudFront hosted zone ID (usually Z2FDTNDATAQYW2)"
  type        = string
}

variable "backend_internal_alb_dns_name" {
  description = "DNS name of the internal ALB"
  type        = string
}

variable "backend_internal_alb_zone_id" {
  description = "Hosted zone ID of the internal ALB"
  type        = string
}
variable "vpc_id" {
  description = "VPC ID"
  type        = string
}
