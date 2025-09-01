output "certificate_arn" {
  description = "ACM certificate ARN for mallhive.com"
  value       = aws_acm_certificate.cert.arn
}

output "internal_acm_certificate_arn" {
  description = "ACM certificate ARN for *.internal.mallhive.com"
  value       = aws_acm_certificate.internal_cert.arn
}

output "internal_acm_certificate_validation_status" {
  description = "Validation status of internal ACM certificate"
  value       = aws_acm_certificate_validation.internal_cert_validation.certificate_arn
}

output "internal_acm_domain_name" {
  description = "Domain name the internal ACM cert is issued for"
  value       = aws_acm_certificate.internal_cert.domain_name
}
