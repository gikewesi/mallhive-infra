output "public_subnet_1a_id" {
  value = aws_subnet.public_1a.id
}

output "public_subnet_1b_id" {
  value = aws_subnet.public_1b.id
}

output "private_subnet_1a_id" {
  value = aws_subnet.private_1a.id
}

output "isolated_subnet_1a_id" {
  value = aws_subnet.isolated_1a.id
}

output "private_subnet_1b_id" {
  value = aws_subnet.private_1b.id
}

output "isolated_subnet_1b_id" {
  value = aws_subnet.isolated_1b.id
}

output "db_subnet_group_name" {
  value = aws_db_subnet_group.db_subnet_group.name
}
