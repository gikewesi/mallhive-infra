variable "vpc_id" {
  description = "VPC ID for ALB"
  type        = string
}

variable "eks_sg_id" {
  description = "Security Group ID of EKS Fargate pods"
  type        = string
}

variable "cdn_ip_ranges" {
  description = "List of CDN IP ranges (e.g., CloudFront) allowed to access ALB"
  type        = list(string)
}

