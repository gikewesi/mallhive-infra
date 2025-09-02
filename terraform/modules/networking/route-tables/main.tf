resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id
  tags = {
    Name = "mallhive-igw"
  }
}

# Elastic IPs for NAT Gateways
resource "aws_eip" "nat_1a" {
  domain = "vpc"
}

resource "aws_eip" "nat_1b" {
  domain = "vpc"
}

# NAT Gateway for us-east-1a
resource "aws_nat_gateway" "nat_1a" {
  allocation_id = aws_eip.nat_1a.id
  subnet_id     = var.public_subnet_1a_id

  tags = {
    Name = "mallhive-natgw-1a"
  }

  depends_on = [aws_internet_gateway.igw]
}

# NAT Gateway for us-east-1b
resource "aws_nat_gateway" "nat_1b" {
  allocation_id = aws_eip.nat_1b.id
  subnet_id     = var.public_subnet_1b_id

  tags = {
    Name = "mallhive-natgw-1b"
  }

  depends_on = [aws_internet_gateway.igw]
}

# Public Route Tables (one per AZ)
resource "aws_route_table" "public_rt_1a" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "mallhive-public-rt-1a"
  }
}

resource "aws_route_table" "public_rt_1b" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "mallhive-public-rt-1b"
  }
}

# Public route associations
resource "aws_route_table_association" "public_assoc_1a" {
  subnet_id      = var.public_subnet_1a_id
  route_table_id = aws_route_table.public_rt_1a.id
}

resource "aws_route_table_association" "public_assoc_1b" {
  subnet_id      = var.public_subnet_1b_id
  route_table_id = aws_route_table.public_rt_1b.id
}

# Private Route Table 1a (microservices)
resource "aws_route_table" "private_rt_1a" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_1a.id
  }

  tags = {
    Name = "mallhive-private-rt-1a"
  }
}

resource "aws_route_table_association" "private_microservices_assoc_1a" {
  subnet_id      = var.private_subnet_1a_id
  route_table_id = aws_route_table.private_rt_1a.id
}

# Private Route Table 1b (microservices)
resource "aws_route_table" "private_rt_1b" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_1b.id
  }

  tags = {
    Name = "mallhive-private-rt-1b"
  }
}

resource "aws_route_table_association" "private_microservices_assoc_1b" {
  subnet_id      = var.private_subnet_1b_id
  route_table_id = aws_route_table.private_rt_1b.id
}

# Private Route Tables for isolated DB subnets (no route to internet)
resource "aws_route_table" "isolated_rt_1a" {
  vpc_id = var.vpc_id

  tags = {
    Name = "mallhive-isolated-rt-1a"
  }
}

resource "aws_route_table_association" "private_db_assoc_1a" {
  subnet_id      = var.isolated_subnet_1a_id
  route_table_id = aws_route_table.isolated_rt_1a.id
}

resource "aws_route_table" "isolated_rt_1b" {
  vpc_id = var.vpc_id

  tags = {
    Name = "mallhive-isolated-rt-1b"
  }
}

resource "aws_route_table_association" "private_db_assoc_1b" {
  subnet_id      = var.isolated_subnet_1b_id
  route_table_id = aws_route_table.isolated_rt_1b.id
}
