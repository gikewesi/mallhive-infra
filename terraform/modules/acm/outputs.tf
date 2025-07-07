output "certificate_arn" {
  description = "ARN of the validated ACM certificate"
  value       = aws_acm_certificate_validation.cert.certificate_arn
}

output "domain_validation_options" {
  description = "Debug output for DNS validation status"
  value       = aws_acm_certificate.cert.domain_validation_options
}
