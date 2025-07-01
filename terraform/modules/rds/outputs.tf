output "users_db_endpoint" {
  description = "Endpoint of the mallhive-users RDS instance"
  value       = aws_db_instance.mallhive_users.endpoint
}

output "product_db_endpoint" {
  description = "Endpoint of the mallhive-product RDS instance"
  value       = aws_db_instance.mallhive_product.endpoint
}

output "order_db_endpoint" {
  description = "Endpoint of the mallhive-order RDS instance"
  value       = aws_db_instance.mallhive_order.endpoint
}

