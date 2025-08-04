# 🧾 User Service – Deployment on AWS EKS with Fargate

This repository contains the Kubernetes Helm chart and deployment configuration for the **User Service**, a FastAPI-based authentication microservice designed to run securely and scalably on **Amazon EKS with Fargate**.

---

## 🧩 Overview

The **User Service** handles:

* User registration and login
* JWT token issuance and validation
* Database interactions with **PostgreSQL on AWS RDS**
* Event publishing to the **Notification Service**
* Runtime credential access via **AWS Secrets Manager**
* Secure HTTPS ingress via **ACM-backed ALB**

---

## 🔧 Architecture

* **Kubernetes Platform**: Amazon EKS (1 cluster, Fargate profiles per microservice)
* **Networking**: Internal **ALB** + **Route 53**, private subnets only
* **Database**: PostgreSQL (provisioned via AWS RDS)
* **Secrets**: Managed via AWS Secrets Manager
* **Image Registry**: Amazon ECR (`mallhive-user-service`)
* **Ingress Security**: HTTPS with **ACM certificate**, internal DNS via `user.internal.mallhive.com`
* **Namespace**: `user-service` (with its own Fargate profile)
* **Service Communication**: Across microservices using DNS (`service-name.namespace.svc.cluster.local`) + `NetworkPolicy`

---

## 📁 Folder Structure

```
user-service/
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

This service **does not store any secrets in Kubernetes**. All secrets (like DB creds, JWT secret) are fetched at runtime using `boto3` from **Secrets Manager**, using **IAM Role for Service Account (IRSA)**.

### IAM Permissions

```json
{
  "Effect": "Allow",
  "Action": [
    "secretsmanager:GetSecretValue"
  ],
  "Resource": "arn:aws:secretsmanager:us-east-1:123456789012:secret:user-service/*"
}
```

## 📦 Deployment via Helm

```bash
helm upgrade --install user-service ./helm \
  --namespace user-service \
  --create-namespace
```

> This assumes:
>
> * You have IRSA and Fargate profile created for `user-service`
> * The ECR image is pushed
> * Your ACM cert + Route 53 entries are valid

---

## 📊 Monitoring & Observability

| Layer                | Tooling                                        |
| -------------------- | ---------------------------------------------- |
| EKS Control Plane    | CloudTrail, CloudWatch Logs                    |
| Fargate Metrics      | CloudWatch Container Insights                  |
| Pod Health & Metrics | Prometheus + AlertManager                      |
| Logs                 | CloudWatch or third-party logging like Datadog |
| App Tracing (opt)    | OpenTelemetry or X-Ray                         |

---

## ✅ Requirements

* ✅ EKS cluster w/ Fargate enabled
* ✅ IRSA-enabled `ServiceAccount` and IAM role
* ✅ RDS PostgreSQL instance in same VPC
* ✅ ALB Ingress Controller and valid ACM cert
* ✅ DNS record in Route 53
* ✅ Helm installed and configured with kubeconfig
* ✅ ECR image pushed (`mallhive-user-service`)

---

## 🔐 Inter-Service Communication (within cluster)

Services talk to each other using Kubernetes DNS:

```
http://notification-service.notification.svc.cluster.local
```

To allow cross-namespace traffic securely:

* Use `NetworkPolicy` with `namespaceSelector` + `podSelector`
* Or use a service mesh (if planning for mTLS)

---

