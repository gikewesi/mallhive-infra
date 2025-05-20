resource "aws_subnet" "mallhive_public_1a" {
  vpc_id                  = aws_vpc.mallhive.id
  cidr_block              = var.mallhive_public_1a_cidr_block
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "mallhive-public-1a"
    Tier = "public"
  }
}

resource "aws_subnet" "mallhive_public_1b" {
  vpc_id                  = aws_vpc.mallhive.id
  cidr_block              = var.mallhive_public_1b_cidr_block
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "mallhive-public-1b"
    Tier = "public"
  }
}

resource "aws_subnet" "mallhive_private_1a" {
  vpc_id            = aws_vpc.mallhive.id
  cidr_block        = var.mallhive_private_1a_cidr_block
  availability_zone = "us-east-1a"

  tags = {
    Name = "mallhive-private-1a"
    Tier = "private"
  }
}

resource "aws_subnet" "mallhive_isolated_1a" {
  vpc_id            = aws_vpc.mallhive.id
  cidr_block        = var.mallhive_isolated_1a_cidr_block
  availability_zone = "us-east-1a"

  tags = {
    Name = "mallhive-isolated-1a"
    Tier = "private"
  }
}

resource "aws_subnet" "mallhive_private_1b" {
  vpc_id            = aws_vpc.mallhive.id
  cidr_block        = var.mallhive_private_1b_cidr_block
  availability_zone = "us-east-1b"

  tags = {
    Name = "mallhive-private-1b"
    Tier = "private"
  }
}

resource "aws_subnet" "mallhive_isolated_1b" {
  vpc_id            = aws_vpc.mallhive.id
  cidr_block        = var.mallhive_isolated_1b_cidr_block
  availability_zone = "us-east-1b"

  tags = {
    Name = "mallhive-isolated-1b"
    Tier = "private"
  }
}
