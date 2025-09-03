variable "vpc_id" {
  description = "VPC ID for the VPC Endpoint Security Group"
  type        = string
}

variable "eks_sg_id" {
  description = "List of Security Group IDs for EKS (Fargate or Node Groups) allowed to access VPC endpoints"
  type        = string
}

