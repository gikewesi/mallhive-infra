variable "vpc_security_group_ids" {
  description = "Security groups to attach to the RDS instance"
  type        = list(string)
}

variable "users_password" {
  description = "Password for mallhive RDS instances"
  type        = string
  sensitive   = true
}

variable "db_subnet_group_name" {
  type = string
}
