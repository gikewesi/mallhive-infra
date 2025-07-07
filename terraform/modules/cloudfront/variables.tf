variable "acm_certificate_arn" {
  description = "ACM certificate ARN (must be in us-east-1)"
  type        = string
}

variable "domain_name" {
  description = "Custom domain (e.g. www.mallhive.com)"
  type        = string
}

variable "bucket_name" {
  description = "S3 bucket name"
  type        = string
}

variable "bucket_arn" {
  description = "S3 bucket ARN"
  type        = string
}

variable "bucket_domain_name" {
  description = "S3 bucket regional domain name (used as CloudFront origin)"
  type        = string
}
