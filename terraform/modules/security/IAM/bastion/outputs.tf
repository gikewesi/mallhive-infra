output "bastion_role_name" {
  description = "The name of the bastion IAM role"
  value       = aws_iam_role.bastion_role.name
}

output "bastion_role_arn" {
  description = "The ARN of the bastion IAM role"
  value       = aws_iam_role.bastion_role.arn
}

output "bastion_instance_profile_name" {
  description = "The name of the IAM instance profile for the bastion host"
  value       = aws_iam_instance_profile.bastion.name
}
