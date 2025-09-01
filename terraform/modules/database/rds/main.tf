provider "aws" {
  region = "us-east-1"
}

resource "aws_db_instance" "mallhive_users" {
  identifier              = "mallhive-users-db"
  engine                  = "postgres"
  engine_version          = "15.5"
  instance_class          = "db.t4g.micro"
  allocated_storage       = 20
  db_subnet_group_name    = var.db_subnet_group_name
  #vpc_security_group_ids  = var.vpc_security_group_ids
  username                = "mallhive-admin"
  password                = var.users_password
  db_name                 = "mallhive-users"
  skip_final_snapshot     = true
  publicly_accessible     = false
  storage_encrypted       = true

  tags = {
    Name = "mallhive-users-db"
  }
}

resource "aws_db_instance" "mallhive_product" {
  identifier              = "mallhive-product-db"
  engine                  = "postgres"
  engine_version          = "15.5"
  instance_class          = "db.t4g.micro"
  allocated_storage       = 20
  db_subnet_group_name    = var.db_subnet_group_name
  #vpc_security_group_ids  = var.vpc_security_group_ids
  username                = "mallhive-admin"
  password                = var.users_password
  db_name                 = "mallhive-product"
  skip_final_snapshot     = true
  publicly_accessible     = false
  storage_encrypted       = true

  tags = {
    Name = "mallhive-product-db"
  }
}

resource "aws_db_instance" "mallhive_order" {
  identifier              = "mallhive-order-db"
  engine                  = "postgres"
  engine_version          = "15.5"
  instance_class          = "db.t4g.micro"
  allocated_storage       = 20
  db_subnet_group_name    = var.db_subnet_group_name
  #vpc_security_group_ids  = var.vpc_security_group_ids
  username                = "mallhive-admin"
  password                = var.users_password
  db_name                 = "mallhive-order"
  skip_final_snapshot     = true
  publicly_accessible     = false
  storage_encrypted       = true

  tags = {
    Name = "mallhive-order-db"
  }
}
