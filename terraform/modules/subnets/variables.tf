

variable "mallhive-public-1a-cidr_block" {
  description = "CIDR block for public subnet in AZ1"
  type        = string
}

variable "mallhive-public-1b-cidr_block" {
  description = "CIDR block for public subnet in AZ2"
  type        = string
}

variable "mallhive-private-1a-cidr_block" {
  description = "CIDR block for first private subnet in AZ1"
  type        = string
}

variable "mallhive-isolated-1a-cidr_block" {
  description = "CIDR block for second private subnet in AZ1"
  type        = string
}

variable "mallhive-private-1b-cidr_block" {
  description = "CIDR block for first private subnet in AZ2"
  type        = string
}

variable "mallhive-isolated-1b-cidr_block" {
  description = "CIDR block for second private subnet in AZ2"
  type        = string
}
