resource "aws_security_group" "db_sg" {
  name        = "db-sg"
  description = "RDS Postgres SG - allow inbound only from trusted SGs"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    { Name = "db-sg" },
    var.tags
  )
}


#  inbound rules (Postgres: 5432)
resource "aws_security_group_rule" "db_ingress" {
  for_each                 = toset(var.trusted_sg_ids)
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  source_security_group_id = each.value
  security_group_id        = aws_security_group.db_sg.id
}

