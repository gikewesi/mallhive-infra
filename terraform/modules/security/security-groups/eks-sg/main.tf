resource "aws_security_group" "eks_sg" {
  name        = "eks-sg"
  description = "Security group for EKS Fargate profile allowing ALB ingress, AWS API egress, and Route53 DNS"
  vpc_id      = var.vpc_id

}

# Ingress: Allow HTTPS from ALB only
resource "aws_security_group_rule" "ingress_from_alb" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.eks_sg.id
  source_security_group_id = var.alb_security_group_id
  description              = "Allow frontend HTTPS requests from ALB"
}

# Egress: Allow HTTPS outbound to ALB and AWS services
resource "aws_security_group_rule" "egress_https" {
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.eks_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow outbound HTTPS to ALB, AWS services, and Route 53 names"
}

# Egress: DNS resolution (for Route 53 private hosted zones)
resource "aws_security_group_rule" "egress_dns" {
  type              = "egress"
  from_port         = 53
  to_port           = 53
  protocol          = "udp"
  security_group_id = aws_security_group.eks_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow DNS resolution"
}

resource "aws_security_group_rule" "egress_dns_tcp" {
  type              = "egress"
  from_port         = 53
  to_port           = 53
  protocol          = "tcp"
  security_group_id = aws_security_group.eks_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow DNS resolution over TCP (for large responses)"
}
