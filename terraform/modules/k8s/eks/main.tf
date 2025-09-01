provider "aws" {
  region = "us-east-1"
}
resource "aws_iam_role" "eks" {
  name = "eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = {
        Service = "eks.amazonaws.com"
      }
    }]
  })
}
resource "aws_iam_role_policy_attachment" "eks_cluster_AmazonEKSClusterPolicy" {
  role       = aws_iam_role.eks.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}
resource "aws_iam_role_policy_attachment" "eks_cluster_AmazonEKSServicePolicy" {
  role       = aws_iam_role.eks.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
}
resource "aws_eks_cluster" "cluster" {
  name     = "mallhive-eks"
  role_arn = aws_iam_role.eks.arn
  version  = "1.27"

  vpc_config {
    subnet_ids = [
      var.private_subnet_1a_id,
      var.private_subnet_1b_id,
    ]
  }
}

resource "aws_iam_role" "fargate_pod_execution" {
  name = "eks-fargate-pod-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "eks-fargate-pods.amazonaws.com"
      }
    }]
  })
}


resource "aws_iam_role_policy_attachment" "fargate_pod_execution_attachment" {
  role       = aws_iam_role.fargate_pod_execution.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy"
}
resource "aws_eks_fargate_profile" "user_service" {
  cluster_name           = aws_eks_cluster.cluster.name
  fargate_profile_name   = "user-service"
  pod_execution_role_arn = aws_iam_role.fargate_pod_execution.arn

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
  pod_execution_role_arn = aws_iam_role.fargate_pod_execution.arn

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
  pod_execution_role_arn = aws_iam_role.fargate_pod_execution.arn

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
  pod_execution_role_arn = aws_iam_role.fargate_pod_execution.arn

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
  pod_execution_role_arn = aws_iam_role.fargate_pod_execution.arn

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
  pod_execution_role_arn = aws_iam_role.fargate_pod_execution.arn

  subnet_ids = [
    var.private_subnet_1a_id,
    var.private_subnet_1b_id,
  ]

  selector {
    namespace = "analytics-service"
  }

  depends_on = [aws_eks_cluster.cluster]
}
resource "aws_eks_fargate_profile" "recommendations_service" {
  cluster_name           = aws_eks_cluster.cluster.name
  fargate_profile_name   = "recommendations-service"
  pod_execution_role_arn = aws_iam_role.fargate_pod_execution.arn

  subnet_ids = [
    var.private_subnet_1a_id,
    var.private_subnet_1b_id,
  ]

  selector {
    namespace = "rescommendations-service"
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
