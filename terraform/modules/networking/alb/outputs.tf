output "alb_dns_name" {
  description = "The DNS name of the load balancer"
  value       = aws_lb.private_alb.dns_name
}

output "alb_zone_id" {
  description = "The canonical hosted zone ID of the load balancer"
  value       = aws_lb.private_alb.zone_id
}

output "alb_arn" {
  description = "The ARN of the load balancer"
  value       = aws_lb.private_alb.arn
}

output "https_listener_arn" {
  description = "The ARN of the HTTPS listener"
  value       = aws_lb_listener.https.arn
}

# Target group ARNs for individual services
output "user_target_group_arn" {
  description = "ARN of the user service target group"
  value       = aws_lb_target_group.user.arn
}

output "cart_target_group_arn" {
  description = "ARN of the cart service target group"
  value       = aws_lb_target_group.cart.arn
}

output "payment_target_group_arn" {
  description = "ARN of the payment service target group"
  value       = aws_lb_target_group.payment.arn
}

output "order_target_group_arn" {
  description = "ARN of the order service target group"
  value       = aws_lb_target_group.order.arn
}

output "product_target_group_arn" {
  description = "ARN of the product service target group"
  value       = aws_lb_target_group.product.arn
}

output "analytics_target_group_arn" {
  description = "ARN of the analytics service target group"
  value       = aws_lb_target_group.analytics.arn
}

output "recommendation_target_group_arn" {
  description = "ARN of the recommendation service target group"
  value       = aws_lb_target_group.recommendation.arn
}

output "notification_target_group_arn" {
  description = "ARN of the notification service target group"
  value       = aws_lb_target_group.notification.arn
}

# For backward compatibility - if you need a single target group reference
output "target_group_arn" {
  description = "ARN of the user target group (default/primary)"
  value       = aws_lb_target_group.user.arn
}

output "listener_arn" {
  description = "ARN of the HTTPS listener (for backward compatibility)"
  value       = aws_lb_listener.https.arn
}

