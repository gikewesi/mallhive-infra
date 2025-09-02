resource "aws_iam_role" "db_role" {
  name = "db-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com" 
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Attach RDS full access
resource "aws_iam_role_policy_attachment" "rds_full" {
  role       = aws_iam_role.db_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonRDSFullAccess"
}

# Attach AWS Backup full access
resource "aws_iam_role_policy_attachment" "backup_full" {
  role       = aws_iam_role.db_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSBackupFullAccess"
}

# Attach Secrets Manager read/write
resource "aws_iam_role_policy_attachment" "secrets_full" {
  role       = aws_iam_role.db_role.name
  policy_arn = "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
}
