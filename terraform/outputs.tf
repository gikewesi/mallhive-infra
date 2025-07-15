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


output "bastion_1a_instance_id" {
  description = "ID of the bastion host instance in subnet 1a"
  value       = module.bastion.bastion_1a_instance_id
}

output "bastion_1a_public_ip" {
  description = "Public IP of the bastion host instance in subnet 1a"
  value       = module.bastion.bastion_1a_public_ip
}

output "bastion_1b_instance_id" {
  description = "ID of the bastion host instance in subnet 1b"
  value       = module.bastion.bastion_1b_instance_id
}

output "bastion_1b_public_ip" {
  description = "Public IP of the bastion host instance in subnet 1b"
  value       = module.bastion.bastion_1b_public_ip
}

output "bastion_sg_id" {
  description = "Security group ID attached to bastion hosts"
  value       = module.bastion.bastion_sg_id
}

output "eks_cluster_name" {
  value = module.eks.eks_cluster_name
}

output "eks_cluster_endpoint" {
  value = module.eks.eks_cluster_endpoint
}

output "eks_cluster_certificate_authority_data" {
  value = module.eks.eks_cluster_certificate_authority_data
}

output "eks_cluster_arn" {
  value = module.eks.eks_cluster_arn
}

output "fargate_pod_execution_role_arn" {
  value = module.eks.fargate_pod_execution_role_arn
}

output "kubeconfig_path" {
  value = module.eks.kubeconfig_path
}

output "ecr_user_service_url" {
  value = module.ecr.ecr_user_service_url
}

output "ecr_order_service_url" {
  value = module.ecr.ecr_order_service_url
}

output "ecr_payment_service_url" {
  value = module.ecr.ecr_payment_service_url
}

output "ecr_cart_service_url" {
  value = module.ecr.ecr_cart_service_url
}

output "ecr_product_service_url" {
  value = module.ecr.ecr_product_service_url
}

output "ecr_recommendations_service_url" {
  value = module.ecr.ecr_recommendations_service_url
}

output "ecr_analytics_service_url" {
  value = module.ecr.ecr_analytics_service_url
}

output "ecr_task_execution_role_arn" {
  value = module.ecr.ecr_task_execution_role_arn
}
