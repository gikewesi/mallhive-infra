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

resource "aws_ecr_repository" "notification_service" {
  name = "${var.repository_name}-notification-service"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Environment = "production"
    Terraform   = "true"
  }
}
