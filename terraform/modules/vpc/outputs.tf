output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.mallhive.id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = aws_vpc.mallhive.cidr_block
}
