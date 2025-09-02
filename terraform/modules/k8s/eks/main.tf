resource "aws_eks_cluster" "cluster" {
  name     = "mallhive-eks"
  role_arn = var.eks_role_arn
  version  = "1.27"

  vpc_config {
    subnet_ids = [
      var.private_subnet_1a_id,
      var.private_subnet_1b_id,
    ]
    security_group_ids = [var.eks_sg_id]
    endpoint_private_access = true
  }
}
resource "aws_eks_fargate_profile" "user_service" {
  cluster_name           = aws_eks_cluster.cluster.name
  fargate_profile_name   = "user-service"
  pod_execution_role_arn = var.fargate_pod_execution_role_arn

  subnet_ids = [
    var.private_subnet_1a_id,
    var.private_subnet_1b_id,
  ]
  selector {
    namespace = "user-service"
  }

  depends_on = [aws_eks_cluster.cluster]
}
resource "aws_eks_fargate_profile" "product_service" {
  cluster_name           = aws_eks_cluster.cluster.name
  fargate_profile_name   = "product-service"
  pod_execution_role_arn = var.fargate_pod_execution_role_arn

  subnet_ids = [
    var.private_subnet_1a_id,
    var.private_subnet_1b_id,
  ]

  selector {
    namespace = "product-service"
  }

  depends_on = [aws_eks_cluster.cluster]
}
resource "aws_eks_fargate_profile" "order_service" {
  cluster_name           = aws_eks_cluster.cluster.name
  fargate_profile_name   = "order-service"
  pod_execution_role_arn = var.fargate_pod_execution_role_arn

  subnet_ids = [
    var.private_subnet_1a_id,
    var.private_subnet_1b_id,
  ]

  selector {
    namespace = "order-service"
  }

  depends_on = [aws_eks_cluster.cluster]
}
resource "aws_eks_fargate_profile" "cart_service" {
  cluster_name           = aws_eks_cluster.cluster.name
  fargate_profile_name   = "cart-service"
  pod_execution_role_arn = var.fargate_pod_execution_role_arn

  subnet_ids = [
    var.private_subnet_1a_id,
    var.private_subnet_1b_id,
  ]

  selector {
    namespace = "cart-service"
  }

  depends_on = [aws_eks_cluster.cluster]
}
resource "aws_eks_fargate_profile" "payment_service" {
  cluster_name           = aws_eks_cluster.cluster.name
  fargate_profile_name   = "payment-service"
  pod_execution_role_arn = var.fargate_pod_execution_role_arn

  subnet_ids = [
    var.private_subnet_1a_id,
    var.private_subnet_1b_id,
  ]

  selector {
    namespace = "payment-service"
  }

  depends_on = [aws_eks_cluster.cluster]
}
resource "aws_eks_fargate_profile" "analytics_service" {
  cluster_name           = aws_eks_cluster.cluster.name
  fargate_profile_name   = "analytics-service"
  pod_execution_role_arn = var.fargate_pod_execution_role_arn

  subnet_ids = [
    var.private_subnet_1a_id,
    var.private_subnet_1b_id,
  ]

  selector {
    namespace = "analytics-service"
  }

  depends_on = [aws_eks_cluster.cluster]
}
resource "aws_eks_fargate_profile" "recommendation_service" {
  cluster_name           = aws_eks_cluster.cluster.name
  fargate_profile_name   = "recommendation-service"
  pod_execution_role_arn = var.fargate_pod_execution_role_arn

  subnet_ids = [
    var.private_subnet_1a_id,
    var.private_subnet_1b_id,
  ]

  selector {
    namespace = "recommendation-service"
  }

  depends_on = [aws_eks_cluster.cluster]
}

resource "aws_eks_fargate_profile" "notification_service" {
  cluster_name           = aws_eks_cluster.cluster.name
  fargate_profile_name   = "notification-service"
  pod_execution_role_arn = var.fargate_pod_execution_role_arn

  subnet_ids = [
    var.private_subnet_1a_id,
    var.private_subnet_1b_id,
  ]

  selector {
    namespace = "notification-service"
  }

  depends_on = [aws_eks_cluster.cluster]
}

resource "local_file" "kubeconfig" {
  content = templatefile("${path.module}/kubeconfig.tpl", {
    cluster_name     = aws_eks_cluster.cluster.name
    cluster_endpoint = aws_eks_cluster.cluster.endpoint
    cluster_ca       = aws_eks_cluster.cluster.certificate_authority[0].data
  })

  filename = "./mallhive-infra/terraform/modules/eks/kubeconfig.yaml"
}
