# 🛒 Cart Service – Deployment on AWS EKS with Fargate

This folder contains the Kubernetes Helm chart and deployment configuration for the **Cart Service**, a Go-based microservice for managing shopping cart operations within the Mallhive platform. It is designed to run securely and scalably on **Amazon EKS with Fargate**.

---

## 🧩 Overview

The **Cart Service** handles:

* Adding and removing products from a cart
* Fetching cart contents for users
* Tracking product availability during checkout
* Publishing checkout events to other services
* Maintaining cart state in **Redis**
* Persisting inventory data in **PostgreSQL on AWS RDS**
* Secure HTTPS ingress via **ACM-backed ALB**

---

## 🔧 Architecture

* **Kubernetes Platform**: Amazon EKS (1 cluster, Fargate profiles per microservice)
* **Networking**: Internal **ALB** + **Route 53**, private subnets only
* **In-Memory Store**: Redis (for cart state)
* **Database**: PostgreSQL (AWS RDS for inventory data)
* **Events**: AWS SNS for publishing checkout events
* **Image Registry**: Amazon ECR (`mallhive-cart-service`)
* **Ingress Security**: HTTPS with **ACM certificate**, internal DNS via `cart.internal.mallhive.com`
* **Namespace**: `cart-service` (with its own Fargate profile)
* **Service Communication**: Across microservices using DNS (`service-name.namespace.svc.cluster.local`) + `NetworkPolicy`

---

## 📡 Service Communication

### Services/Microfrontends that Send Requests to Cart Service

* **🛒 cart.mallhive.com (Microfrontend)** – Fetch cart, add/remove items
* **💳 checkout.mallhive.com (Microfrontend)** – Get final cart details before checkout

### Services the Cart Service Sends Requests/Events to

* **✅ Product Service** – Confirm item status on checkout (via event)
* **📊 Analytics Service** – Send cart usage metrics/events

### Services that Send Direct Requests to Cart Service

* **None** – No direct service-to-service incoming requests

---

## 📁 Folder Structure

```
cart-service/
├── helm/
│   ├── Chart.yaml
│   ├── values.yaml
│   └── templates/
│       ├── configmap.yaml
│       ├── deployment.yaml
│       ├── hpa.yaml
│       ├── ingress.yaml
│       ├── service.yaml
│       ├── serviceaccount.yaml
│       ├── networkpolicy.yaml
│       ├── namespace.yaml
├── README.md
```

---

## 🔐 Secrets & IAM (IRSA)

The Cart Service **does not store secrets in Kubernetes**. All credentials (e.g., DB credentials, Redis connection details, SNS topics) are fetched at runtime from **AWS Secrets Manager**, using **IAM Role for Service Account (IRSA)**.

### IAM Permissions

```json
{
  "Effect": "Allow",
  "Action": [
    "secretsmanager:GetSecretValue",
    "sns:Publish"
  ],
  "Resource": [
    "arn:aws:secretsmanager:us-east-1:123456789012:secret:cart-service/*",
    "arn:aws:sns:us-east-1:123456789012:checkout-events"
  ]
}
```

---

## 📦 Deployment via Helm

```bash
helm upgrade --install cart-service ./helm \
  --namespace cart-service \
  --create-namespace
```

> This assumes:
>
> * You have IRSA and Fargate profile created for `cart-service`
> * The ECR image is pushed
> * Your ACM cert + Route 53 entries are valid

---

## 📊 Monitoring & Observability

| Layer               | Tooling                                                          |
| ------------------- | ---------------------------------------------------------------- |
| EKS Control Plane   | CloudWatch                                                       |
| Fargate Pod Metrics | Prometheus (cAdvisor via kubelet), Alertmanager for alerts       |
| Logs                | Loki + Promtail (pod logs, Kubernetes events, ingress logs)      |
| Visualization       | Grafana (single pane for metrics, logs, and traces)              |
| Cluster Autoscaling | Karpenter for dynamic scaling of workloads                       |
| Policy & Governance | Kyverno for admission control, security, and compliance policies |

---


## ✅ Requirements

* ✅ EKS cluster w/ Fargate enabled
* ✅ IRSA-enabled `ServiceAccount` and IAM role
* ✅ RDS PostgreSQL and Redis in same VPC
* ✅ ALB Ingress Controller and valid ACM cert
* ✅ DNS record in Route 53 (`cart.internal.mallhive.com`)
* ✅ Helm installed and configured with kubeconfig
* ✅ ECR image pushed (`mallhive-cart-service`)

---