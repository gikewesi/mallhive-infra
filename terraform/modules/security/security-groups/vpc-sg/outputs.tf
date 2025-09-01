output "vpc_endpoints_sg_id" {
  description = "Security Group ID for VPC interface endpoints"
  value       = aws_security_group.vpc_sg.id
}

output "vpc_endpoints_sg_arn" {
  description = "Security Group ARN for VPC interface endpoints"
  value       = aws_security_group.vpc_sg.arn
}
