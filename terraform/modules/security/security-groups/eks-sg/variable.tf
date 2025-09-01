variable "vpc_id" {
  description = "The VPC ID where the security group will be created"
  type        = string
}

variable "alb_security_group_id" {
  description = "The security group ID of the ALB that will talk to EKS"
  type        = string
}
