variable "private_subnet_1a_id" {
  description = "Subnet ID for private subnet in availability zone 1a"
  type        = string
}

variable "private_subnet_1b_id" {
  description = "Subnet ID for private subnet in availability zone 1b"
  type        = string
}

variable "node_group_desired_capacity" {
  description = "Desired number of nodes in the EKS node group"
  type        = number
  default     = 2
}

variable "node_group_max_capacity" {
  description = "Maximum number of nodes in the EKS node group"
  type        = number
  default     = 3
}

variable "node_group_min_capacity" {
  description = "Minimum number of nodes in the EKS node group"
  type        = number
  default     = 1
}

variable "node_instance_type" {
  description = "EC2 instance type for EKS node group"
  type        = string
  default     = "t3.medium"
}
