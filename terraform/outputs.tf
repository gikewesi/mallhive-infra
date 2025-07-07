output "vpc_id" {
  value = module.vpc.vpc_id
}

# Subnets
output "public_subnet_1a_id" {
  value = module.subnets.public_subnet_1a_id
}

output "public_subnet_1b_id" {
  value = module.subnets.public_subnet_1b_id
}

output "private_subnet_1a_id" {
  value = module.subnets.private_subnet_1a_id
}

output "private_subnet_1b_id" {
  value = module.subnets.private_subnet_1b_id
}

output "isolated_subnet_1a_id" {
  value = module.subnets.isolated_subnet_1a_id
}

output "isolated_subnet_1b_id" {
  value = module.subnets.isolated_subnet_1b_id
}


# Route Tables
output "public_rt_1a_id" {
  value = module.route_tables.public_rt_1a_id
}

output "public_rt_1b_id" {
  value = module.route_tables.public_rt_1b_id
}

output "private_rt_1a_id" {
  value = module.route_tables.private_rt_1a_id
}

output "private_rt_1b_id" {
  value = module.route_tables.private_rt_1b_id
}

output "isolated_rt_1a_id" {
  value = module.route_tables.isolated_rt_1a_id
}

output "isolated_rt_1b_id" {
  value = module.route_tables.isolated_rt_1b_id
}

# cloudfront
output "cloudfront_distribution_id" {
  value = module.cloudfront.cloudfront_distribution_id
}

output "cloudfront_domain_name" {
  value = module.cloudfront.cloudfront_domain_name
}

#acm
output "acm_certificate_arn" {
  value = module.acm.certificate_arn
}

#s3
output "bucket_domain_name" {
  value = module.s3.bucket_domain_name
}

#route53

output "public_zone_id" {
  description = "Hosted zone ID for mallhive.com"
  value       = module.dns.public_zone_id
}

output "private_zone_id" {
  description = "Hosted zone ID for internal.mallhive.com"
  value       = module.dns.private_zone_id
}

output "frontend_record_fqdn" {
  description = "FQDN for www.mallhive.com CloudFront alias"
  value       = module.dns.frontend_record_fqdn
}

output "backend_record_fqdn" {
  description = "FQDN for api.internal.mallhive.com alias"
  value       = module.dns.backend_record_fqdn
}

#alb

output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

output "alb_zone_id" {
  value = module.alb.alb_zone_id
}

output "target_group_arn" {
  value = module.alb.target_group_arn
}

output "listener_arn" {
  value = module.alb.listener_arn
}
