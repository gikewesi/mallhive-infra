output "eks_role_arn" {
  value = aws_iam_role.eks_role.arn
}

output "fargate_pod_execution_role_name" {
  value = aws_iam_role.fargate_pod_execution_role.name
}

output "fargate_pod_execution_role_arn" {
  value = aws_iam_role.fargate_pod_execution_role.arn
}

output "eks_role_name" {
  value = aws_iam_role.eks_role.name
}