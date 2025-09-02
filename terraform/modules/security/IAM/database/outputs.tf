output "db_role_arn" {
  value       = aws_iam_role.db_role.arn
  description = "ARN of the DB admin IAM role"
}

output "db_role_name" {
  value       = aws_iam_role.db_role.name
  description = "ARN of the DB read-only IAM role"
}    