resource "aws_subnet" "public_1a" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.mallhive_public_1a_cidr_block
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "mallhive-public-1a"
    Tier = "public"
  }
}

resource "aws_subnet" "public_1b" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.mallhive_public_1b_cidr_block
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "mallhive-public-1b"
    Tier = "public"
  }
}

resource "aws_subnet" "private_1a" {
  vpc_id            = var.vpc_id
  cidr_block        = var.mallhive_private_1a_cidr_block
  availability_zone = "us-east-1a"

  tags = {
    Name = "mallhive-private-1a"
    Tier = "private"
  }
}

resource "aws_subnet" "isolated_1a" {
  vpc_id            = var.vpc_id
  cidr_block        = var.mallhive_isolated_1a_cidr_block
  availability_zone = "us-east-1a"

  tags = {
    Name = "mallhive-isolated-1a"
    Tier = "private"
  }
}

resource "aws_subnet" "private_1b" {
  vpc_id            = var.vpc_id
  cidr_block        = var.mallhive_private_1b_cidr_block
  availability_zone = "us-east-1b"

  tags = {
    Name = "mallhive-private-1b"
    Tier = "private"
  }
}

resource "aws_subnet" "isolated_1b" {
  vpc_id            = var.vpc_id
  cidr_block        = var.mallhive_isolated_1b_cidr_block
  availability_zone = "us-east-1b"

  tags = {
    Name = "mallhive-isolated-1b"
    Tier = "private"
  }
}

#SUBNET GROUP

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "db-subnet-group"
  subnet_ids = [
    var.isolated_subnet_1a_id,
    var.isolated_subnet_1b_id
  ]
  description = "Subnet group for Databases"

  tags = {
    Name = "db-subnet-group"
  }
}
