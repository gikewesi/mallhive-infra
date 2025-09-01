resource "aws_security_group" "alb_sg" {
  name        = "alb-sg"
  description = "Description for the ALB security group"
  vpc_id      = var.vpc_id
  tags = {
    Name = "alb-sg"
  }
}

# Ingress: allow HTTP and HTTPS from CDN / frontend
resource "aws_security_group_rule" "ingress_cdn_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.alb_sg.id
  cidr_blocks       = var.cdn_ip_ranges
  description       = "Allow HTTP from frontend CDN"
}

resource "aws_security_group_rule" "ingress_cdn_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.alb_sg.id
  cidr_blocks       = var.cdn_ip_ranges
  description       = "Allow HTTPS from frontend CDN"
}

# Ingress: allow HTTPS from EKS pods (for health checks)
resource "aws_security_group_rule" "ingress_eks_https" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.alb_sg.id
  source_security_group_id = var.eks_sg_id
  description              = "Allow HTTPS from EKS pods"
}

# Egress: allow HTTPS to EKS pods
resource "aws_security_group_rule" "egress_to_eks" {
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.alb_sg.id
  cidr_blocks       = ["0.0.0.0/0"]  # Can restrict to EKS pod subnets if known
  description       = "Allow HTTPS to EKS pods"
}

# Egress: allow HTTPS to frontend / CDN (usually ALB responses automatically go through)
resource "aws_security_group_rule" "egress_to_frontend" {
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.alb_sg.id
  cidr_blocks       = var.cdn_ip_ranges
  description       = "Allow HTTPS outbound to frontend CDN"
}
