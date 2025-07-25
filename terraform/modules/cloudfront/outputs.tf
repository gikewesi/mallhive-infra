output "cloudfront_distribution_id" {
  value = aws_cloudfront_distribution.cdn.id
}

output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.cdn.domain_name
}

output "cloudfront_zone_id" {
  value = "Z2FDTNDATAQYW2"
}

output "cloudfront_distribution_arn" {
  value = aws_cloudfront_distribution.cdn.arn
}
