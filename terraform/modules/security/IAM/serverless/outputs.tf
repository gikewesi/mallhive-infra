output "serverless_role_name" {
  value       = aws_iam_role.serverless_role.name
  description = "The IAM role name for Serverless services"
}

output "serverless_role_arn" {
  value       = aws_iam_role.serverless_role.arn
  description = "The IAM role ARN for Serverless services"
}
