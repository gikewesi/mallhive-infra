output "eks_sg_id" {
  description = "Security Group ID for EKS Fargate profile"
  value       = aws_security_group.eks_sg.id
}

output "eks_sg_arn" {
  description = "Security Group ARN for EKS Fargate profile"
  value       = aws_security_group.eks_sg.arn
}
