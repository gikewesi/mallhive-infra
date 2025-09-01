variable "vpc_id" {
  description = "VPC ID where bastion will be deployed"
  type        = string
}

variable "public_subnet_1a_id" {
  description = "Public subnet ID to launch bastion host in"
  type        = string
}

variable "public_subnet_1b_id" {
  description = "Public subnet ID to launch bastion host in"
  type        = string
}
variable "instance_type" {
  description = "EC2 instance type for bastion"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Name of the SSH key pair to access bastion host"
  type        = string
  default     = "keypair-bastion"
}

variable "allowed_ssh_cidr_blocks" {
  description = "List of CIDR blocks allowed to SSH into bastion host"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "ami_id" {
  description = "AMI ID for the bastion host instance"
  type        = string
  default     = ""
  # You can pass latest Amazon Linux 2 AMI ID here or look it up outside the module
}
