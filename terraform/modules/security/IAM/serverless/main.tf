resource "aws_iam_role" "serverless_role" {
  name = "serverless-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"  # Lambda service assumes this role
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Attach Secrets Manager access
resource "aws_iam_role_policy_attachment" "secrets" {
  role       = aws_iam_role.serverless_role.name
  policy_arn = "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
}

# Attach SNS full access
resource "aws_iam_role_policy_attachment" "sns" {
  role       = aws_iam_role.serverless_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSNSFullAccess"
}

# Attach EventBridge full access
resource "aws_iam_role_policy_attachment" "eventbridge" {
  role       = aws_iam_role.serverless_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEventBridgeFullAccess"
}

# Attach Lambda full access
resource "aws_iam_role_policy_attachment" "lambda_full" {
  role       = aws_iam_role.serverless_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSLambda_FullAccess"
}

# Attach SQS full access
resource "aws_iam_role_policy_attachment" "sqs_full" {
  role       = aws_iam_role.serverless_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSQSFullAccess"
}
