resource "aws_lb" "private_alb" {
  name               = "mallhive-api-alb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = var.security_group_ids
  subnets            = [
    var.private_subnet_1a_id,
    var.private_subnet_1b_id
  ]

  idle_timeout       = 60

  tags = {
    Name = "mallhive-api-alb"
  }
}

resource "aws_lb_target_group" "backend_tg" {
  name     = "mallhive-api-alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/health"
    protocol            = "HTTP"
    matcher             = "200-399"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "mallhive-api-alb-tg"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.private_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend_tg.arn
  }
}

resource "aws_route53_record" "alb_dns" {
  zone_id = var.private_zone_id
  name    = var.backend_record_fqdn
  type    = "A"

  alias {
    name                   = aws_lb.private_alb.dns_name
    zone_id                = aws_lb.private_alb.zone_id
    evaluate_target_health = true
  }
}
