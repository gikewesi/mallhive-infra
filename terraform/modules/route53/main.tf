provider "aws" {
  region = "us-east-1"
}

data "aws_route53_zone" "frontend" {
  name         = "mallhive.com"
  private_zone = false
}

resource "aws_route53_record" "frontend_alias" {
  zone_id = data.aws_route53_zone.frontend.zone_id
  name    = "www.mallhive.com"
  type    = "A"

  alias {
    name                   = var.cloudfront_domain_name
    zone_id                = var.cloudfront_zone_id
    evaluate_target_health = false
  }
}

data "aws_route53_zone" "backend" {
  name         = "internal.mallhive.com"
  private_zone = true
}

resource "aws_route53_record" "backend_alias" {
  zone_id = data.aws_route53_zone.backend.zone_id
  name    = "api.internal.mallhive.com"
  type    = "A"

  alias {
    name                   = var.backend_internal_alb_dns_name
    zone_id                = var.backend_internal_alb_zone_id
    evaluate_target_health = false
  }
}
