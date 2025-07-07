output "alb_dns_name" {
  value = aws_lb.private_alb.dns_name
}

output "alb_zone_id" {
  value = aws_lb.private_alb.zone_id
}

output "target_group_arn" {
  value = aws_lb_target_group.backend_tg.arn
}

output "listener_arn" {
  value = aws_lb_listener.http.arn
}
