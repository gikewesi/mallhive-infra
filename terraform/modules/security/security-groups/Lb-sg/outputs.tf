output "alb_sg_id" {
  description = "ALB Security Group ID"
  value       = aws_security_group.alb_sg.id
}

output "alb_sg_arn" {
  description = "ALB Security Group ARN"
  value       = aws_security_group.alb_sg.arn
}
