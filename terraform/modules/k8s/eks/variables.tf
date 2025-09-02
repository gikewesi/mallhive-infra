variable "private_subnet_1a_id" {
  description = "Subnet ID for private subnet in availability zone 1a"
  type        = string
}

variable "private_subnet_1b_id" {
  description = "Subnet ID for private subnet in availability zone 1b"
  type        = string
}
variable "fargate_pod_execution_role_arn" {
  description = "The ARN of the IAM role used by EKS Fargate pods"
  type        = string
}

variable "eks_sg_id" {
  description = "The security group ID for the EKS cluster / Fargate pods"
  type        = string
}

variable "eks_role_arn" {
  type = string
}
