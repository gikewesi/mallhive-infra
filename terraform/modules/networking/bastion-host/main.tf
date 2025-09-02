data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_instance" "bastion_1a" {
  ami                         = data.aws_ami.amazon_linux_2.id
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet_1a_id
  key_name                    = var.key_name
  security_groups             = [var.bastion_sg_id]
  iam_instance_profile        = var.bastion_instance_profile
  associate_public_ip_address = true

  tags = {
    Name = "bastion-host"
  }
}

resource "aws_instance" "bastion_1b" {
  ami                         = data.aws_ami.amazon_linux_2.id
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet_1b_id
  key_name                    = var.key_name
  security_groups             = [var.bastion_sg_id]
  iam_instance_profile        = var.bastion_instance_profile
  associate_public_ip_address = true

  tags = {
    Name = "bastion-host-1b"
  }
}
