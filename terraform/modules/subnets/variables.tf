variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "mallhive_public_1a_cidr_block" {
  description = "CIDR block for public subnet in AZ1"
  type        = string
}

variable "mallhive_public_1b_cidr_block" {
  description = "CIDR block for public subnet in AZ2"
  type        = string
}

variable "mallhive_private_1a_cidr_block" {
  description = "CIDR block for first private subnet in AZ1"
  type        = string
}

variable "mallhive_isolated_1a_cidr_block" {
  description = "CIDR block for second private subnet in AZ1"
  type        = string
}

variable "mallhive_private_1b_cidr_block" {
  description = "CIDR block for first private subnet in AZ2"
  type        = string
}

variable "mallhive_isolated_1b_cidr_block" {
  description = "CIDR block for second private subnet in AZ2"
  type        = string
}

variable "isolated_subnet_1a_id" {
  type = string
}

variable "isolated_subnet_1b_id" {
  type = string
}
