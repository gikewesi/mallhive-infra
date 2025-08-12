provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}

# Public ACM Certificate for mallhive.com
resource "aws_acm_certificate" "cert" {
  provider          = aws.us_east_1
  domain_name       = "mallhive.com"
  validation_method = "DNS"

  subject_alternative_names = [
    "*.mallhive.com"
  ]

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "mallhive-mf-cert"
  }
}

resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options :
    dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  }

  zone_id = var.public_zone_id
  name    = each.value.name
  type    = each.value.type
  ttl     = 300
  records = [each.value.record]
}

resource "aws_acm_certificate_validation" "cert" {
  provider                = aws.us_east_1
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for r in aws_route53_record.cert_validation : r.fqdn]
}

# Private ACM for internal services (*.internal.mallhive.com)


resource "aws_acm_certificate" "internal_cert" {
  provider          = aws.us_east_1
  domain_name       = "*.internal.mallhive.com"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "mallhive-internal-cert"
    Env  = "prod"
  }
}

resource "aws_route53_record" "internal_cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.internal_cert.domain_validation_options :
    dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  }

  zone_id = var.public_zone_id
  name    = each.value.name
  type    = each.value.type
  ttl     = 300
  records = [each.value.record]
}

resource "aws_acm_certificate_validation" "internal_cert_validation" {
  provider                = aws.us_east_1
  certificate_arn         = aws_acm_certificate.internal_cert.arn
  validation_record_fqdns = [for r in aws_route53_record.internal_cert_validation : r.fqdn]
}