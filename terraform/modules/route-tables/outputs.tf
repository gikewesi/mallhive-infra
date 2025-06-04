output "internet_gateway_id" {
  value = aws_internet_gateway.igw.id
}

output "nat_gateway_1a_id" {
  value = aws_nat_gateway.nat_1a.id
}

output "nat_gateway_1b_id" {
  value = aws_nat_gateway.nat_1b.id
}

output "public_rt_1a_id" {
  value = aws_route_table.public_rt_1a.id
}

output "public_rt_1b_id" {
  value = aws_route_table.public_rt_1b.id
}

output "private_rt_1a_id" {
  value = aws_route_table.private_rt_1a.id
}

output "private_rt_1b_id" {
  value = aws_route_table.private_rt_1b.id
}

# modules/route-tables/outputs.tf

output "isolated_rt_1a_id" {
  value = aws_route_table.isolated_rt_1a.id
}

output "isolated_rt_1b_id" {
  value = aws_route_table.isolated_rt_1b.id
}
