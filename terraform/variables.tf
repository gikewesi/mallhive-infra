variable "aws_region" {
  description = "AWS region to deploy into"
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

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "users_password" {
  description = "Password for mallhive RDS instances"
  type        = string
  sensitive   = true
}

/*
variable "security_group_ids" {
  description = "Security groups for the ALB"
  type        = list(string)
}
*/
variable "instance_type" {
  description = "EC2 instance type for bastion hosts"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Name of the SSH key pair to access bastion hosts"
  type        = string
}

variable "allowed_ssh_cidr_blocks" {
  description = "List of CIDR blocks allowed to SSH into bastion hosts"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "repository_name" {
  type        = string
  description = "Prefix name used for all ECR repositories"
  default     = "mallhive"
}

variable "private_zone_name" {
  description = "Private Route53 hosted zone name for backend"
  type        = string
  default     = "internal.mallhive.com"
}

variable "security_group_ids" {
  description = "List of security group IDs to attach to the ALB"
  type        = list(string)
  default     = []
}
#bastion_sg
variable "allowed_ip" {
  description = "Your office or VPN IP in CIDR notation"
  type        = string
}
variable "role_name" {
  description = "Name for the bastion IAM role"
  type        = string
  default     = "bastion-role"
}

variable "s3_bucket" {
  description = "S3 bucket that bastion needs access to"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {
    Project = "Mallhive"
    Service = "Bastion"
  }
}
