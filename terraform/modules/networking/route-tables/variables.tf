variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "public_subnet_1a_id" {
  description = "Public subnet ID in us-east-1a"
  type        = string
}

variable "public_subnet_1b_id" {
  description = "Public subnet ID in us-east-1b"
  type        = string
}

variable "private_subnet_1a_id" {
  description = "Private microservices subnet in 1a"
  type        = string
}

variable "private_subnet_1b_id" {
  description = "Private microservices subnet in 1b"
  type        = string
}

variable "isolated_subnet_1a_id" {
  description = "Private (isolated) DB subnet in 1a"
  type        = string
}

variable "isolated_subnet_1b_id" {
  description = "Private (isolated) DB subnet in 1b"
  type        = string
}
