output "ecr_user_service_url" {
  description = "URL of the ECR repository for user-service"
  value       = aws_ecr_repository.user_service.repository_url
}

output "ecr_order_service_url" {
  description = "URL of the ECR repository for order-service"
  value       = aws_ecr_repository.order_service.repository_url
}

output "ecr_payment_service_url" {
  description = "URL of the ECR repository for payment-service"
  value       = aws_ecr_repository.payment_service.repository_url
}

output "ecr_cart_service_url" {
  description = "URL of the ECR repository for cart-service"
  value       = aws_ecr_repository.cart_service.repository_url
}

output "ecr_product_service_url" {
  description = "URL of the ECR repository for product-service"
  value       = aws_ecr_repository.product_service.repository_url
}

output "ecr_recommendations_service_url" {
  description = "URL of the ECR repository for recommendations-service"
  value       = aws_ecr_repository.recommendations_service.repository_url
}

output "ecr_analytics_service_url" {
  description = "URL of the ECR repository for analytics-service"
  value       = aws_ecr_repository.analytics_service.repository_url
}

output "ecr_task_execution_role_arn" {
  description = "IAM Role ARN for ECS tasks to pull images from ECR"
  value       = aws_iam_role.ecr_access.arn
}
