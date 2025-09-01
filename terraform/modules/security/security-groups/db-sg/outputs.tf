output "db_sg_id" {
  description = "The ID of the database Security Group"
  value       = aws_security_group.db_sg.id
}

