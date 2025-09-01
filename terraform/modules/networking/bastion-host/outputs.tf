output "bastion_1a_instance_id" {
  description = "ID of the bastion host instance in subnet 1a"
  value       = aws_instance.bastion_1a.id
}

output "bastion_1a_public_ip" {
  description = "Public IP address of the bastion host in subnet 1a"
  value       = aws_instance.bastion_1a.public_ip
}

output "bastion_1b_instance_id" {
  description = "ID of the bastion host instance in subnet 1b"
  value       = aws_instance.bastion_1b.id
}

output "bastion_1b_public_ip" {
  description = "Public IP address of the bastion host in subnet 1b"
  value       = aws_instance.bastion_1b.public_ip
}

output "bastion_sg_id" {
  description = "Security group ID attached to bastion hosts"
  value       = aws_security_group.bastion_sg.id
}
