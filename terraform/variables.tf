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

variable "vpc_id" {
  description = "VPC where the ALB resides"
  type        = string
}

variable "private_subnet_1a_id" {
  description = "Private subnet ID in AZ 1a for the ALB"
  type        = string
}

variable "private_subnet_1b_id" {
  description = "Private subnet ID in AZ 1b for the ALB"
  type        = string
}

variable "security_group_ids" {
  description = "Security groups for the ALB"
  type        = list(string)
}

variable "private_zone_id" {
  description = "Route 53 private hosted zone ID for backend services"
  type        = string
}

variable "backend_record_fqdn" {
  description = "DNS record name (e.g. api.mallhive.internal)"
  type        = string
}


variable "ami_id" {
  description = "AMI ID for the bastion host instance"
  type        = string
}

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


variable "hosted_zone_id" {
  description = "Public Route53 Hosted Zone ID for mallhive.com"
  type        = string
}

variable "private_zone_name" {
  description = "Private Route53 hosted zone name for backend"
  type        = string
  default     = "internal.mallhive.com"
}
