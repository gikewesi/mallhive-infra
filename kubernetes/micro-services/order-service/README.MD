# 📦 Order Service – Deployment on AWS EKS with Fargate

This folder contains the Kubernetes Helm chart and deployment configuration for the **Order Service**, a Go-based microservice responsible for **order placement, tracking, and fulfillment**. It is designed to run securely and scalably on **Amazon EKS with Fargate**.

---

## 🧩 Overview

The **Order Service** is the backbone of Mallhive's ordering system. It:

* Accepts and processes new orders
* Tracks order status and fulfillment
* Interacts with product, payment, analytics, and notification services
* Publishes domain events via **Kafka** or **AWS EventBridge**
* Stores and queries order data in **PostgreSQL on AWS RDS**
* Runs in a fully containerized, serverless EKS Fargate environment

---

## 🔧 Architecture

* **Kubernetes Platform**: Amazon EKS (1 cluster, Fargate profile for `order-service`)
* **Networking**: Internal **ALB** + **Route 53**, private subnets only
* **Database**: PostgreSQL (AWS RDS)
* **Message/Event Bus**: Kafka or AWS SQS, AWS EventBridge
* **Image Registry**: Amazon ECR (`mallhive-order-service`)
* **Ingress Security**: HTTPS with **ACM certificate**, internal DNS via `order.internal.mallhive.com`
* **Namespace**: `order-service`
* **Service Communication**: Across microservices using DNS + `NetworkPolicy`

---

## 🔗 Service Communication

**Services that send requests to Order Service**
💳 **checkout.mallhive.com** (Microfrontend) → Creates a new order
👤 **user-profile.mallhive.com** (Microfrontend) → Fetches user’s past orders

**Services that receive requests from Order Service**
📦 **Product Microservice** → Update stock when an order is placed
📩 **Notification Microservice** → Send order confirmation to the user
💰 **Payment Microservice** → Initiate and verify payment for the order
📊 **Analytics Microservice** → Log order success or failure events

**Services that respond back to Order Service**
💰 **Payment Microservice** → Confirms if payment was successful or failed

---

## 📁 Folder Structure

```
order-service/
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

The service **does not store any secrets in Kubernetes**. All credentials (e.g., DB credentials, Kafka/SQS credentials) are fetched at runtime from **AWS Secrets Manager**, using **IAM Role for Service Account (IRSA)**.

### IAM Permissions Example

```json
{
  "Effect": "Allow",
  "Action": [
    "secretsmanager:GetSecretValue"
  ],
  "Resource": "arn:aws:secretsmanager:us-east-1:123456789012:secret:order-service/*"
}
```

---

## 🚀 Deployment via Helm

```bash
helm upgrade --install order-service ./helm \
  --namespace order-service \
  --create-namespace
```

> **Prerequisites:**
>
> * IRSA and Fargate profile created for `order-service`
> * ECR image is pushed (`mallhive-order-service`)
> * ACM certificate and Route 53 entries are valid

---

## 📊 Monitoring & Observability

| Layer               | Tooling                                                          |
| ------------------- | ---------------------------------------------------------------- |
| EKS Control Plane   | CloudWatch                                                       |
| Fargate Pod Metrics | Prometheus (cAdvisor via kubelet), Alertmanager for alerts       |
| Logs                | Loki + Promtail (pod logs, Kubernetes events, ingress logs)      |
| Visualization       | Grafana (single pane for metrics, logs, and traces)              |
| Event Processing    | Kafka/AWS SQS monitoring dashboards + EventBridge metrics        |
| Policy & Governance | Kyverno for admission control, security, and compliance policies |

---

## 🗺️ Architecture Diagram

![Order Service Architecture](./ORDER-SERVICE.drawio.png)

---

## ✅ Requirements

* ✅ EKS cluster with Fargate enabled
* ✅ IRSA-enabled `ServiceAccount` and IAM role
* ✅ PostgreSQL (AWS RDS) in same VPC
* ✅ Kafka/SQS + EventBridge configured
* ✅ ALB Ingress Controller and valid ACM certificate
* ✅ Route 53 DNS record
* ✅ Helm installed and configured with kubeconfig
* ✅ ECR image pushed (`mallhive-order-service`)

---