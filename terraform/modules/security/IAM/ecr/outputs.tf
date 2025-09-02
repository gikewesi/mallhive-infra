output "ecr_role_name" {
  value       = aws_iam_role.ecr_role.name
  description = "The IAM role name for pushing to ECR"
}

output "ecr_role_arn" {
  value       = aws_iam_role.ecr_role.arn
  description = "The IAM role ARN for pushing to ECR"
}
