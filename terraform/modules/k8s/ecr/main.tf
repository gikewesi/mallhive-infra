provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_role" "ecr_access" {
  name = "${var.repository_name}-ecr-access-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_policy" "ecr_pull_policy" {
  name        = "${var.repository_name}-ecr-pull-policy"
  description = "Allows pulling images from ECR repos"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability"
        ],
        Resource = [
          aws_ecr_repository.user_service.arn,
          aws_ecr_repository.order_service.arn,
          aws_ecr_repository.payment_service.arn,
          aws_ecr_repository.cart_service.arn,
          aws_ecr_repository.product_service.arn,
          aws_ecr_repository.recommendations_service.arn,
          aws_ecr_repository.analytics_service.arn
        ]
      },
      {
        Effect   = "Allow",
        Action   = "ecr:GetAuthorizationToken",
        Resource = "*"
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "attach_ecr_pull_policy" {
  role       = aws_iam_role.ecr_access.name
  policy_arn = aws_iam_policy.ecr_pull_policy.arn
}

resource "aws_ecr_repository" "user_service" {
  name = "${var.repository_name}-user-service"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Environment = "production"
    Terraform   = "true"
  }
}

resource "aws_ecr_repository" "order_service" {
  name = "${var.repository_name}-order-service"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Environment = "production"
    Terraform   = "true"
  }
}

resource "aws_ecr_repository" "payment_service" {
  name = "${var.repository_name}-payment-service"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Environment = "production"
    Terraform   = "true"
  }
}

resource "aws_ecr_repository" "cart_service" {
  name = "${var.repository_name}-cart-service"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Environment = "production"
    Terraform   = "true"
  }
}

resource "aws_ecr_repository" "product_service" {
  name = "${var.repository_name}-product-service"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Environment = "production"
    Terraform   = "true"
  }
}

resource "aws_ecr_repository" "recommendations_service" {
  name = "${var.repository_name}-recommendations-service"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Environment = "production"
    Terraform   = "true"
  }
}


resource "aws_ecr_repository" "analytics_service" {
  name = "${var.repository_name}-analytics-service"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Environment = "production"
    Terraform   = "true"
  }
}
