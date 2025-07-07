output "public_zone_id" {
  value       = data.aws_route53_zone.frontend.zone_id
  description = "Hosted zone ID for public domain (mallhive.com)"
}

output "private_zone_id" {
  value       = data.aws_route53_zone.backend.zone_id
  description = "Hosted zone ID for private backend domain (internal.mallhive.com)"
}

output "frontend_record_fqdn" {
  value       = aws_route53_record.frontend_alias
  description = "Full domain name for the frontend CloudFront app"
}

output "backend_record_fqdn" {
  value       = aws_route53_record.backend_alias
  description = "Full domain name for internal backend service"
}
