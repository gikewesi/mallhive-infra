output "public_zone_id" {
  value       = data.aws_route53_zone.frontend.zone_id
  description = "Hosted zone ID for public domain (mallhive.com)"
}

output "private_zone_id" {
  value       = data.aws_route53_zone.backend.zone_id
  description = "Hosted zone ID for private backend domain (internal.mallhive.com)"
}

output "userprofile_record_fqdn" {
  value       = aws_route53_record.userprofile_microfrontend.fqdn
  description = "FQDN for userprofile frontend microfrontend"
}

output "shoppingcart_record_fqdn" {
  value       = aws_route53_record.shoppingcart_microfrontend.fqdn
  description = "FQDN for shoppingcart frontend microfrontend"
}

output "product_record_fqdn" {
  value       = aws_route53_record.product_microfrontend.fqdn
  description = "FQDN for product frontend microfrontend"
}

output "checkout_record_fqdn" {
  value       = aws_route53_record.checkout_microfrontend.fqdn
  description = "FQDN for checkout frontend microfrontend"
}

output "homepage_record_fqdn" {
  value       = aws_route53_record.homepage_microfrontend.fqdn
  description = "FQDN for homepage frontend microfrontend"
}

output "user_record_fqdn" {
  value       = aws_route53_record.user.fqdn
  description = "Internal FQDN for user microservice"
}

output "order_record_fqdn" {
  value       = aws_route53_record.order.fqdn
  description = "Internal FQDN for order microservice"
}

output "cart_record_fqdn" {
  value       = aws_route53_record.cart.fqdn
  description = "Internal FQDN for cart microservice"
}

output "payment_record_fqdn" {
  value       = aws_route53_record.payment.fqdn
  description = "Internal FQDN for payment microservice"
}

output "product_record_fqdn" {
  value       = aws_route53_record.product.fqdn
  description = "Internal FQDN for product microservice"
}

output "notification_record_fqdn" {
  value       = aws_route53_record.notification.fqdn
  description = "Internal FQDN for notification microservice"
}

output "analytics_record_fqdn" {
  value       = aws_route53_record.analytics.fqdn
  description = "Internal FQDN for analytics microservice"
}
output "recommendation_record_fqdn" {
  value       = aws_route53_record.recommendation.fqdn
  description = "Internal FQDN for recommendation microservice"
}