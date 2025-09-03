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
output "certificate_arn" {
  description = "ACM certificate ARN for mallhive.com"
  value       = module.acm.certificate_arn
}

output "internal_acm_certificate_arn" {
  description = "ACM certificate ARN for *.internal.mallhive.com"
  value       = module.acm.internal_acm_certificate_arn
}

output "internal_acm_certificate_validation_status" {
  description = "Validation status of internal ACM certificate"
  value       = module.acm.internal_acm_certificate_validation_status
}

output "internal_acm_domain_name" {
  description = "Domain name the internal ACM cert is issued for"
  value       = module.acm.internal_acm_domain_name
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

/*output "frontend_record_fqdn" {
  description = "FQDN for www.mallhive.com CloudFront alias"
  value       = module.dns.frontend_record_fqdn
}



output "user_record_fqdn" {
  value       = module.dns.user_record_fqdn
  description = "Internal FQDN for user microservice"
}

output "order_record_fqdn" {
  value       = module.dns.order_record_fqdn
  description = "Internal FQDN for order microservice"
}

output "cart_record_fqdn" {
  value       = module.dns.cart_record_fqdn
  description = "Internal FQDN for cart microservice"
}

output "payment_record_fqdn" {
  value       = module.dns.payment_record_fqdn
  description = "Internal FQDN for payment microservice"
}

output "product_record_fqdn" {
  value       = module.dns.product_record_fqdn
  description = "Internal FQDN for product microservice"
}

output "notification_record_fqdn" {
  value       = module.dns.notification_record_fqdn
  description = "Internal FQDN for notification microservice"
}

output "analytics_record_fqdn" {
  value       = module.dns.analytics.fqdn
  description = "Internal FQDN for analytics microservice"
}
output "recommendation_record_fqdn" {
  value       = module.dns.analytics_record_fqdn
  description = "Internal FQDN for recommendation microservice"
}
*/
#alb
output "alb_dns_name" {
  description = "The DNS name of the load balancer"
  value       = module.alb.alb_dns_name
}

output "alb_zone_id" {
  description = "The canonical hosted zone ID of the load balancer"
  value       = module.alb.alb_zone_id
}

output "alb_arn" {
  description = "The ARN of the load balancer"
  value       = module.alb.alb_arn
}

output "https_listener_arn" {
  description = "The ARN of the HTTPS listener"
  value       = module.alb.https_listener_arn
}

# Individual target group ARNs (useful for ECS services)
output "user_target_group_arn" {
  value = module.alb.user_target_group_arn
}

output "cart_target_group_arn" {
  value = module.alb.cart_target_group_arn
}

output "payment_target_group_arn" {
  value = module.alb.payment_target_group_arn
}

output "order_target_group_arn" {
  value = module.alb.order_target_group_arn
}

output "product_target_group_arn" {
  value = module.alb.product_target_group_arn
}

output "analytics_target_group_arn" {
  value = module.alb.analytics_target_group_arn
}

output "recommendation_target_group_arn" {
  value = module.alb.recommendation_target_group_arn
}

output "notification_target_group_arn" {
  value = module.alb.notification_target_group_arn
}

#bastion
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

output "ecr_notification_service_url" {
  value = module.ecr.ecr_notification_service_url
}
#bastion_sg
output "bastion_sg_id" {
  description = "The ID of the bastion SG"
  value       = module.bastion_sg.bastion_sg_id
}
#database_sg
output "db_sg_id" {
  description = "The ID of the database SG"
  value       = module.db_sg.db_sg_id
}

#eks_sg
output "eks_sg_id" {
  description = "Security Group ID for EKS Fargate profile"
  value       = module.eks_sg.eks_sg_id
}

output "eks_sg_arn" {
  description = "Security Group ARN for EKS Fargate profile"
  value       = module.eks_sg.eks_sg_arn
}

#alb_sg
output "alb_sg_id" {
  description = "Security Group ID for the Application Load Balancer"
  value       = module.alb_sg.alb_sg_id
}

output "alb_sg_arn" {
  description = "Security Group ARN for the Application Load Balancer"
  value       = module.alb_sg.alb_sg_arn
}

#cache_sg
output "cache_sg_id" {
  description = "Security group ID for cache"
  value       = module.cache_sg.cache_sg_id
}
#vpc_sg
output "vpc_sg_id" {
  description = "Security Group ID for VPC interface endpoints"
  value       = module.vpc_sg.vpc_sg_id
}

output "vpc_sg_arn" {
  description = "Security Group ARN for VPC interface endpoints"
  value       = module.vpc_sg.vpc_sg_arn
}

output "bastion_role_name" {
  value       = module.bastion_role.bastion_role_name
  description = "IAM role name for bastion"
}
output "bastion_role_arn" {
  value = module.bastion_role.bastion_role_arn
}

output "bastion_instance_profile_name" {
  description = "The IAM instance profile name for the bastion host"
  value       = module.bastion_role.bastion_instance_profile_name
}


output "cache_role_arn" {
  value = module.cache_role.cache_role_arn
}
output "cache_role_name" {
  value = module.cache_role.cache_role_name
}
output "db_role_arn" {
  value = module.db_role.db_role_arn
}
output "db_role_name" {
  value = module.db_role.db_role_name
}

output "eks_role_arn" {
  value = module.eks_role.eks_role_arn
}
output "eks_role_name" {
  value = module.eks_role.eks_role_name
}

output "serverless_role_name" {
  value       = module.serverless_role.serverless_role_name
  description = "The IAM role name for Serverless services"
}

output "serverless_role_arn" {
  value       = module.serverless_role.serverless_role_arn
  description = "The IAM role ARN for Serverless services"
}
output "ecr_role_name" {
  value       = module.ecr_role.ecr_role_name
  description = "The IAM role name for pushing to ECR"
}

output "ecr_role_arn" {
  value       = module.ecr_role.ecr_role_arn
  description = "The IAM role ARN for pushing to ECR"
}

output "fargate_pod_execution_role_arn" {
  value = module.eks_role.fargate_pod_execution_role_arn
}
output "fargate_pod_execution_role_name" {
  value = module.eks_role.fargate_pod_execution_role_name
}