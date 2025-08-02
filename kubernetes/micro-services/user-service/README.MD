# User Service – Kubernetes Deployment on AWS EKS

This folder contains Kubernetes manifests for deploying the **User Service** authentication microservice on **Amazon EKS**, running with **Fargate**, using **AWS-native secret management** and autoscaling.

---

## 📌 Overview

The **User Service** is a FastAPI-based microservice responsible for:

- User registration and authentication
- JWT token generation and validation
- Integration with PostgreSQL (hosted on AWS RDS)
- Sending login/register events to a notification microservice
- Secure runtime secret access from AWS Secrets Manager via IAM Roles for Service Accounts (IRSA)

---

## 🔧 Architecture

- **EKS with Fargate**: Runs in a private subnet, scheduled via the `user-service` Fargate profile
- **Amazon ECR**: App container image is stored in a private ECR repo named `mallhive-user-service`
- **RDS**: PostgreSQL database lives outside Kubernetes (not deployed via K8s manifests)
- **AWS Secrets Manager**: App secrets like DB credentials and JWT secret are **fetched at runtime**
- **Route 53 + ALB**: Internal ALB handles traffic to `api.internal-mallhive.com`, routing to the service in private subnets

---

## 📁 Folder Structure

```

user-service/
├── helm/                     # Helm chart for production-grade deployment
│   ├── Chart.yaml
│   ├── values.yaml
│   └── templates/
│       ├── configmap.yaml
│       ├── deployment.yaml
│       ├── hpa.yaml
│       ├── ingress.yaml
│       ├── service.yaml
│       ├── serviceaccount.yaml
│       ├── network-policy.yaml
│       ├── namespace.yaml
├── README.MD
      
```
---

## 🔐 Secrets and IAM

- **Secrets are never stored in Kubernetes.**
- The app uses the AWS SDK (`boto3`) to fetch secrets from **Secrets Manager** using the `DB_SECRET_NAME` key.
- A dedicated **IAM Role** is created and bound to the Kubernetes `ServiceAccount` via **IRSA**.
- This role has permissions like:

```json
{
  "Effect": "Allow",
  "Action": "secretsmanager:GetSecretValue",
  "Resource": "arn:aws:secretsmanager:us-east-1:123456789012:secret:user-service/*"
}
```

---

##  Configuration (via ConfigMap)

Non-sensitive environment variables (stored in a ConfigMap):

| Variable                             | Purpose                                  |
| -------------------------------------| ---------------------------------------- |
| `USER_SERVICE_SECRET_NAME`           | AWS Secrets Manager name for DB creds    |

---

##  Deployment

### Helm

```bash
helm upgrade --install user-service ./helm \
  --namespace user-service \
  --create-namespace
```

---

## 🌐 Ingress + Networking

* Requests to `api.internal-mallhive.com` are routed via an **internal ALB**.
* The ALB is provisioned and managed via annotations in the Ingress resource.
* DNS is managed in **Route 53**, and the subdomain points to the ALB.

**NetworkPolicy** is defined to restrict pod ingress only from allowed IP blocks.

---

##  Autoscaling

The deployment includes a **HorizontalPodAutoscaler** that scales between 2 and 5 replicas based on CPU usage.

---

##  FastAPI App Highlights

* Secrets like `DB_USER`, `DB_PASS`, and `SECRET_KEY` are **not passed via Kubernetes env vars**
* App uses `boto3` to fetch the credentials from Secrets Manager securely
* JWT-based authentication with access tokens
* `/health` endpoint supports readiness and liveness probes

---

##  Requirements

Before deploying:

* EKS cluster with Fargate and `user-service` profile
* RDS PostgreSQL instance reachable from EKS VPC
* Internal ALB ingress controller installed and IAM permissions set
* ECR repo named `mallhive-user-service` with latest image
* Secrets created in AWS Secrets Manager
* Route53 domain for `user.internal.mallhive.com` pointing to the ALB

---

##  Next Steps

* Add observability tooling (e.g. Datadog, Prometheus, CloudWatch)
* Enable structured logging and log forwarding
* Define alerts and thresholds for the HPA
* Secure internal service-to-service comms using mTLS or service mesh (if needed)

---

## 🧠 Notes

* **No PostgreSQL is deployed inside Kubernetes**. The database is managed externally via AWS RDS.
* This setup is production-ready and aligns with AWS best practices for EKS and Fargate.
* By using IRSA and runtime secret fetching, I avoided static secret injection and improve long-term security posture.
