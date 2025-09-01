variable "vpc_id" {
  description = "VPC ID where SG will be created"
  type        = string
}

variable "eks_sg_id" {
  description = "EKS security group ID that should have access"
  type        = string
}

variable "cache_port" {
  description = "Port for Redis/Memcached"
  type        = number
  default     = 6379
}

variable "tags" {
  description = "Additional tags to apply"
  type        = map(string)
  default     = {}
}
