resource "aws_security_group" "vpc_sg" {
  name        = "vpc-sg"
  description = "Security group for VPC interface endpoints (Secrets Manager, SSM, STS, KMS, CloudWatch, etc.)"
  vpc_id      = var.vpc_id

  tags = {
    Name = "vpc-sg"
  }
}

# Ingress: Allow HTTPS from EKS security groups
resource "aws_security_group_rule" "ingress_from_eks" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.vpc_sg.id
  source_security_group_id = var.eks_sg_id # first SG
}

# Optional: if multiple EKS SGs, create rules for each
resource "aws_security_group_rule" "ingress_from_eks_list" {

  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.vpc_sg.id
  source_security_group_id = var.eks_sg_id
}

# Egress: Allow all traffic (default AWS behavior for endpoints)
resource "aws_security_group_rule" "egress_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.vpc_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
}
