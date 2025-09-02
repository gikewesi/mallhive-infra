resource "aws_iam_role" "cache_role" {
  name = "cache-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com" # typically used if EC2 apps connect to ElastiCache
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Attach ElastiCache full access
resource "aws_iam_role_policy_attachment" "elasticache_full" {
  role       = aws_iam_role.cache_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonElastiCacheFullAccess"
}

# Attach Secrets Manager read/write
resource "aws_iam_role_policy_attachment" "secrets_full" {
  role       = aws_iam_role.cache_role.name
  policy_arn = "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
}
