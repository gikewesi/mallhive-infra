resource "aws_security_group" "cache_sg" {
  name        = "cache-sg"
  description = "Security group for cache (Redis/Memcached), only allows inbound from EKS SG"
  vpc_id      = var.vpc_id

  ingress {
    description     = "Allow inbound traffic from EKS SG"
    from_port       = var.cache_port
    to_port         = var.cache_port
    protocol        = "tcp"
    security_groups = [var.eks_sg_id]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags,
    {
      Name = "cache-sg"
    }
  )
}
