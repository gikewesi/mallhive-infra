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

  vpc_id = module.vpc.vpc_id
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

  vpc_id                      = module.vpc.vpc_id
  public_subnet_1a_id   = module.subnets.public_subnet_1a_id
  public_subnet_1b_id   = module.subnets.public_subnet_1b_id
  private_subnet_1a_id  = module.subnets.private_subnet_1a_id
  private_subnet_1b_id  = module.subnets.private_subnet_1b_id
  isolated_subnet_1a_id = module.subnets.isolated_subnet_1a_id
  isolated_subnet_1b_id = module.subnets.isolated_subnet_1b_id
}
