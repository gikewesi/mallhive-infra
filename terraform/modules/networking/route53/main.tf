# Public zone
resource "aws_route53_zone" "frontend" {
  name = "mallhive.com"
}

# Private zone
resource "aws_route53_zone" "backend" {
  name = "internal.mallhive.com"

  vpc {
    vpc_id = var.vpc_id
  }
}


data "aws_route53_zone" "frontend" {
  name         = "mallhive.com."
  private_zone = false
}

resource "aws_route53_record" "userprofile_microfrontend" {
  zone_id = data.aws_route53_zone.frontend.zone_id
  name    = "user.mallhive.com"
  type    = "A"

  alias {
    name                   = var.cloudfront_domain_name
    zone_id                = var.cloudfront_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "shoppingcart_microfrontend" {
  zone_id = data.aws_route53_zone.frontend.zone_id
  name    = "cart.mallhive.com"
  type    = "A"

  alias {
    name                   = var.cloudfront_domain_name
    zone_id                = var.cloudfront_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "product_microfrontend" {
  zone_id = data.aws_route53_zone.frontend.zone_id
  name    = "product.mallhive.com"
  type    = "A"

  alias {
    name                   = var.cloudfront_domain_name
    zone_id                = var.cloudfront_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "checkout_microfrontend" {
  zone_id = data.aws_route53_zone.frontend.zone_id
  name    = "checkout.mallhive.com"
  type    = "A"

  alias {
    name                   = var.cloudfront_domain_name
    zone_id                = var.cloudfront_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "homepage_microfrontend" {
  zone_id = data.aws_route53_zone.frontend.zone_id
  name    = "home.mallhive.com"
  type    = "A"

  alias {
    name                   = var.cloudfront_domain_name
    zone_id                = var.cloudfront_zone_id
    evaluate_target_health = false
  }
}
data "aws_route53_zone" "backend" {
  name         = "internal.mallhive.com."
  private_zone = true
}

resource "aws_route53_record" "user" {
  zone_id = data.aws_route53_zone.backend.zone_id
  name    = "user.internal.mallhive.com"
  type    = "A"

  alias {
    name                   = var.backend_internal_alb_dns_name
    zone_id                = var.backend_internal_alb_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "order" {
  zone_id = data.aws_route53_zone.backend.zone_id
  name    = "order.internal.mallhive.com"
  type    = "A"

  alias {
    name                   = var.backend_internal_alb_dns_name
    zone_id                = var.backend_internal_alb_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "cart" {
  zone_id = data.aws_route53_zone.backend.zone_id
  name    = "cart.internal.mallhive.com"
  type    = "A"

  alias {
    name                   = var.backend_internal_alb_dns_name
    zone_id                = var.backend_internal_alb_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "payment" {
  zone_id = data.aws_route53_zone.backend.zone_id
  name    = "payment.internal.mallhive.com"
  type    = "A"

  alias {
    name                   = var.backend_internal_alb_dns_name
    zone_id                = var.backend_internal_alb_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "product" {
  zone_id = data.aws_route53_zone.backend.zone_id
  name    = "product.internal.mallhive.com"
  type    = "A"

  alias {
    name                   = var.backend_internal_alb_dns_name
    zone_id                = var.backend_internal_alb_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "notification" {
  zone_id = data.aws_route53_zone.backend.zone_id
  name    = "notification.internal.mallhive.com"
  type    = "A"

  alias {
    name                   = var.backend_internal_alb_dns_name
    zone_id                = var.backend_internal_alb_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "analytics" {
  zone_id = data.aws_route53_zone.backend.zone_id
  name    = "analytics.internal.mallhive.com"
  type    = "A"

  alias {
    name                   = var.backend_internal_alb_dns_name
    zone_id                = var.backend_internal_alb_zone_id
    evaluate_target_health = false
  }
}


resource "aws_route53_record" "recommendation" {
  zone_id = data.aws_route53_zone.backend.zone_id
  name    = "recommendation.internal.mallhive.com"
  type    = "A"

  alias {
    name                   = var.backend_internal_alb_dns_name
    zone_id                = var.backend_internal_alb_zone_id
    evaluate_target_health = false
  }
}