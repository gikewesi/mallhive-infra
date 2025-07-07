output "bucket_arn" {
  value       = aws_s3_bucket.static_site.arn
  description = "ARN of the S3 bucket"
}

output "bucket_domain_name" {
  value       = aws_s3_bucket.static_site.bucket_domain_name
  description = "Regional domain name used by CloudFront origin"
}

output "website_endpoint" {
  value       = aws_s3_bucket.static_site.website_endpoint
  description = "Website endpoint for testing (optional)"
}
