# 🏗️ MallHive Infrastructure

This repository contains infrastructure code, Kubernetes manifests, CI/CD automation, and observability for the **MallHive e-commerce platform**.
It manages everything from provisioning clusters and deploying services to monitoring, security, and data pipelines.

---

## 📐 High-Level Architecture

```mermaid
flowchart LR
    A[Users] --> B[Route53 / CloudFront / ALB]
    B --> C[EKS Cluster]
    C -->|Microservices| D[(RDS / S3 / OpenSearch)]
    C --> E[ETL Pipeline (Kinesis + Lambda)]
    C --> F[Observability (Prometheus + Grafana + Loki)]
```

---

## 📁 Repo Structure

```plaintext
mallhive-infra/
├── argocd/                   # Argo CD Applications (per microservice + app-of-apps)
├── codebuild/                # AWS CodeBuild buildspecs
├── codepipeline/             # CloudFormation templates for CodePipeline
├── ci/                       # Jenkins pipelines (ETL, EKS, shared logic)
├── dockerfiles/              # Dockerfiles for all microservices
├── etl-pipeline/             # ETL jobs and Lambda code
├── kubernetes/               # Kubernetes add-ons, operators, and microservices
├── observability/            # Monitoring & logging stack (Prometheus, Grafana, Loki, CloudWatch)
├── MLOps/                    # MLOps pipelines and workflows
├── scripts/                  # Helper automation scripts
└── terraform
└── README.md

```

---

## 🧩 Components by Concern

* **Infrastructure** → Terraform modules, Karpenter autoscaling, AWS Load Balancer Controller
* **Application Delivery** → Argo CD apps, Kubernetes manifests, Dockerfiles
* **Data & Analytics** → ETL pipeline (Kinesis + Lambda), Redshift/S3 integration
* **Observability** → Prometheus, Grafana dashboards, Loki logs, CloudWatch exporters
* **Security** → Kyverno policies, IAM least privilege, AWS Secrets Manager, TLS/ACM
* **MLOps** → Training and deployment workflows (future scope)

---

## 📦 Microservices

| Service            | Dockerfile Path                         | Deployment Path                                      |
| ------------------ | --------------------------------------- | ---------------------------------------------------- |
| User Service       | `dockerfiles/user.dockerfile`           | `kubernetes/micro-services/user-service/`            |
| Order Service      | `dockerfiles/order.dockerfile`          | `kubernetes/micro-services/order-service/`           |
| Product Service    | `dockerfiles/product.dockerfile`        | `kubernetes/micro-services/product-service/`         |
| Payment Service    | `dockerfiles/payment.dockerfile`        | `kubernetes/micro-services/payment-service/`         |
| Cart Service       | `dockerfiles/shoppingcart.dockerfile`   | `kubernetes/micro-services/cart-service/`            |
| Recommendation Svc | `dockerfiles/recommendation.dockerfile` | `kubernetes/micro-services/recommendations-service/` |
| Analytics Service  | `dockerfiles/analytics.dockerfile`      | `kubernetes/micro-services/analytics-service/`       |

---

## 🚀 Quickstart

### 1. Provision Infrastructure

```bash
cd terraform/environments/dev
terraform init
terraform apply
```

### 2. Bootstrap Argo CD

```bash
kubectl apply -f kubernetes/argocd/namespace.yaml
kubectl apply -f argocd/app-of-apps.yaml
```

### 3. Build & Push a Microservice

```bash
docker build -t <ECR_REPO>/mallhive-user:latest -f dockerfiles/user.dockerfile .
docker push <ECR_REPO>/mallhive-user:latest
```

Argo CD will sync deployments automatically.

---

## 📊 ETL Pipeline

MallHive includes an **event-driven ETL system** for analytics.

* `etl-pipeline/lambda/` → Lambda transformation logic
* `terraform/etl/` → Infra setup (Kinesis, IAM, Lambda)
* `ci/etl/` → Jenkins pipelines
* `.github/workflows/etl-pipeline.yml` → GitHub Actions alternative

---

## 🔍 Observability

The `observability/` stack provides full visibility:

* **Prometheus** → metrics scraping
* **Grafana** → dashboards
* **Loki** → logs
* **CloudWatch** → AWS metrics + exporters

---

## 🛡️ Security

* Secrets in **AWS Secrets Manager** or **SSM Parameter Store**
* **Kyverno** policies for pod security and image signing
* **KMS** encryption for sensitive data
* **IAM least privilege** enforced across CI/CD and services

---

## 📌 Future Improvements

* [ ] Add service mesh (Linkerd or Istio)
* [ ] Integrate OpenTelemetry tracing
* [ ] Expand MLOps pipelines for model deployment
* [ ] Harden CI/CD with artifact signing

---

## ✍️ Contributions

Infra evolves fast. Open a PR or issue if you have improvements or fixes.

---