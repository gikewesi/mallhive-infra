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