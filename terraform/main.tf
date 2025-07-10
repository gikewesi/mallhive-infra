terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.3.0"
}

provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
}

module "subnets" {
  source = "./modules/subnets"

  vpc_id                          = module.vpc.vpc_id
  mallhive_public_1a_cidr_block   = var.mallhive_public_1a_cidr_block
  mallhive_public_1b_cidr_block   = var.mallhive_public_1b_cidr_block
  mallhive_private_1a_cidr_block  = var.mallhive_private_1a_cidr_block
  mallhive_private_1b_cidr_block  = var.mallhive_private_1b_cidr_block
  mallhive_isolated_1a_cidr_block = var.mallhive_isolated_1a_cidr_block
  mallhive_isolated_1b_cidr_block = var.mallhive_isolated_1b_cidr_block
  isolated_subnet_1a_id           = module.subnets.isolated_subnet_1a_id
  isolated_subnet_1b_id           = module.subnets.isolated_subnet_1b_id
}

module "route_tables" {
  source = "./modules/route-tables"

  vpc_id                = module.vpc.vpc_id
  public_subnet_1a_id   = module.subnets.public_subnet_1a_id
  public_subnet_1b_id   = module.subnets.public_subnet_1b_id
  private_subnet_1a_id  = module.subnets.private_subnet_1a_id
  private_subnet_1b_id  = module.subnets.private_subnet_1b_id
  isolated_subnet_1a_id = module.subnets.isolated_subnet_1a_id
  isolated_subnet_1b_id = module.subnets.isolated_subnet_1b_id
}

module "rds" {
  source = "./modules/rds"

  db_subnet_group_name     = module.subnets.db_subnet_group_name
  vpc_security_group_ids   = [aws_security_group.rds.id]
  users_password           = var.users_password
}
module "dns" {
  source = "./modules/route53"

  cloudfront_domain_name        = module.cloudfront.cloudfront_domain_name           
  cloudfront_zone_id            = module.cloudfront.cloudfront_zone_id       

  backend_internal_alb_dns_name = module.backend_alb.dns_name
  backend_internal_alb_zone_id  = module.backend_alb.zone_id
}


module "s3" {
  source = "./modules/s3"
}

module "cloudfront" {
  source                 = "./modules/cloudfront"
  bucket_name            = "mallhive-s3"
  bucket_arn             = module.s3.bucket_arn
  bucket_domain_name     = module.s3.bucket_domain_name
  acm_certificate_arn    = module.acm.certificate_arn
  domain_name            = "www.mallhive.com"
}

module "acm" {
  source          = "./modules/acm"
  domain_name     = "mallhive.com"
  alt_names       = [] # optional
  hosted_zone_id  = module.dns.public_zone_id
}

module "alb" {
  source                = "./modules/alb"
  vpc_id                = module.vpc.vpc_id
  private_subnet_1a_id  = module.subnets.private_subnet_1a_id
  private_subnet_1b_id  = module.subnets.private_subnet_1b_id
  security_group_ids    = var.security_group_ids
  private_zone_id       = module.dns.private_zone_id
  backend_record_fqdn   = module.dns.backend_record_fqdn
}

module "bastion" {
  source = "./modules/bastion-host"

  vpc_id              = module.vpc.vpc_id
  public_subnet_1a_id = module.subnets.public_subnet_1a_id
  public_subnet_1b_id = module.subnets.public_subnet_1b_id
  ami_id              = var.ami_id
  instance_type       = var.instance_type
  key_name            = var.key_name
  allowed_ssh_cidr_blocks = var.allowed_ssh_cidr_blocks
}

