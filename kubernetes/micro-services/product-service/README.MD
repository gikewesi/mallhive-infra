# 🧾 Product Service – Deployment on AWS EKS with Fargate

This folder contains the Kubernetes Helm chart and deployment configuration for the **Product Service**, a Go-based microservice responsible for managing product data and serving product information to both internal services and frontend applications. It runs securely and scalably on **Amazon EKS with Fargate**.

---

## 🧩 Overview

The **Product Service** handles:

* Product catalog management (create, update, delete products)
* Category and filter management
* Pricing and stock level tracking
* Availability verification during checkout
* Metadata delivery for analytics and recommendations
* Database interactions with **PostgreSQL on AWS RDS**
* Runtime credential access via **AWS Secrets Manager**
* Secure HTTPS ingress via **ACM-backed ALB**

---

## 🔧 Architecture

* **Kubernetes Platform**: Amazon EKS (1 cluster, Fargate profiles per microservice)
* **Networking**: Internal **ALB** + **Route 53**, private subnets only
* **Database**: PostgreSQL (provisioned via AWS RDS)
* **Secrets**: Managed via AWS Secrets Manager
* **Image Registry**: Amazon ECR (`mallhive-product-service`)
* **Ingress Security**: HTTPS with **ACM certificate**, internal DNS via `product.internal.mallhive.com`
* **Namespace**: `product-service` (with its own Fargate profile)
* **Service Communication**: Across microservices using DNS (`service-name.namespace.svc.cluster.local`) + `NetworkPolicy`

---

## 📡 Interactions

### 📥 Product Service Receives Requests From:

| Sender                          | Type           | Reason                                                                 |
| -------------------------------- | -------------- | ----------------------------------------------------------------------- |
| `cart.mallhive.com`              | Microfrontend  | Display product name and price for items in the user's cart             |
| `products.mallhive.com`          | Microfrontend  | Fetch product catalog, categories, and filters                         |
| `homepage.mallhive.com`          | Microfrontend  | Show featured or new products on the homepage                           |
| `checkout.mallhive.com`          | Microfrontend  | Verify final product availability at checkout                           |
| Cart microservice                | Microservice   | Verify product data (price, stock, name) during checkout                |
| Order microservice               | Microservice   | Lock inventory once an order is placed                                  |

### 📤 Product Service Sends To:

| Receiver                         | Type           | Reason                                                                 |
| -------------------------------- | -------------- | ----------------------------------------------------------------------- |
| Analytics microservice           | Microservice   | Log events like view, click, and save for tracking and reporting        |
| Recommendation microservice      | Microservice   | Send product metadata for building personalized recommendations         |

---

## 📁 Folder Structure

```

product-service/
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

This service **does not store any secrets in Kubernetes**. All secrets (like DB creds) are fetched at runtime using `boto3` (or AWS SDK for Go) from **Secrets Manager**, using **IAM Role for Service Account (IRSA)**.

### IAM Permissions

```json
{
  "Effect": "Allow",
  "Action": [
    "secretsmanager:GetSecretValue"
  ],
  "Resource": "arn:aws:secretsmanager:us-east-1:123456789012:secret:product-service/*"
}
```

---

## 📦 Deployment via Helm

```bash
helm upgrade --install product-service ./helm \
  --namespace product-service \
  --create-namespace
```

> This assumes:
>
> * You have IRSA and Fargate profile created for `product-service`
> * The ECR image is pushed
> * Your ACM cert + Route 53 entries are valid

---

## 📊 Monitoring & Observability

| Layer               | Tooling                                                          |
| ------------------- | ---------------------------------------------------------------- |
| EKS Control Plane   | Cloudwatch                                                       |
| Fargate Pod Metrics | Prometheus (cAdvisor via kubelet), Alertmanager for alerts       |
| Logs                | Loki + Promtail (pod logs, Kubernetes events, ingress logs)      |
| Visualization       | Grafana (single pane for metrics, logs, and traces)              |
| Cluster Autoscaling | Karpenter for dynamic scaling of workloads                       |
| Policy & Governance | Kyverno for admission control, security, and compliance policies |

---

---

## ✅ Requirements

* ✅ EKS cluster w/ Fargate enabled
* ✅ IRSA-enabled `ServiceAccount` and IAM role
* ✅ RDS PostgreSQL instance in same VPC
* ✅ ALB Ingress Controller and valid ACM cert
* ✅ DNS record in Route 53
* ✅ Helm installed and configured with kubeconfig
* ✅ ECR image pushed (`mallhive-product-service`)

---

## 🔐 Inter-Service Communication (within cluster)

Services talk to each other using Kubernetes DNS:

```
http://analytics-service.analytics.svc.cluster.local
http://recommendation-service.recommendation.svc.cluster.local

```

To allow cross-namespace traffic securely:

* Use `NetworkPolicy` with `namespaceSelector` + `podSelector`
* Or use a service mesh (if planning for mTLS)

```
