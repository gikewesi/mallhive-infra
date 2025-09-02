output "cache_role_arn" {
  description = "IAM Role ARN for ElastiCache"
  value       = aws_iam_role.cache_role.arn
}

output "cache_role_name" {
  description = "IAM Role Name for ElastiCache"
  value       = aws_iam_role.cache_role.name
}