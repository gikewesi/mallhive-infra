# 🏗️ MallHive Infrastructure

This repository shows how I designed and built the **infrastructure backbone for MallHive**, a cloud-native e-commerce platform.

The goal was to create an environment where developers can ship features fast, while the platform stays **scalable, observable, and secure**.

---

## 🧠 Thought Process

### The Problem

E-commerce platforms have many moving parts—user authentication, product catalogs, payment flows, analytics, recommendations. Running them at scale isn’t just about features. Behind the scenes, we need:
* Infrastructure that **scales with demand** (flash sales, seasonal spikes)
* **Reliable CI/CD pipelines** so developers can ship quickly without breaking things
* **Security-first design** (payments + customer data require strict controls)
* **Observability** for troubleshooting across distributed microservices
* Room for **future AI/ML workloads** like recommendations and personalization

### The Approach

I broke the solution into modular layers. Each folder in this repo represents a **concern in the platform**:
* **Infrastructure as Code (Terraform)** for consistent environments
* **CI/CD automation** for predictable releases
* **Kubernetes + Argo CD** for microservice deployments with GitOps
* **Observability stack** for metrics, logs, and dashboards
* **Serverless + ETL pipelines** for data analytics and event processing
* **MLOps (future scope)** to bring ML into production safely

### The Result

A system that is:

* **Highly automated** (infra, builds, deployments all codified)
* **Secure by default** (IAM least privilege, Secrets Manager, encryption)
* **Observable end-to-end** (metrics, logs, dashboards across cloud + apps)
* **Flexible** (supports microservices, serverless, and ML pipelines)---

---

## 📐 High-Level Architecture

```
flowchart LR
    A[Users] --> B[Route53 / CloudFront / ALB]
    B --> C[EKS Cluster]
    C -->|Microservices| D[(RDS / S3 / OpenSearch)]
    C --> E[ETL + Serverless (Kinesis + Lambda)]
    C --> F[Observability (Prometheus + Grafana + Loki)]
    C --> G[MLOps Pipelines (future)]
```

---

## 📁 Repo Structure

```plaintext
mallhive-infra/
├── argocd/         # GitOps apps (per microservice + app-of-apps)
├── ci-cd/          # Build & deploy pipelines (CodePipeline, Jenkins, GitHub Actions)
├── docker/         # Dockerfiles for all services
├── etl/            # Event-driven data pipelines (Kinesis + Lambda)
├── kubernetes/     # Manifests for services, add-ons, operators
├── mlops/          # ML model training & deployment workflows
├── observability/  # Monitoring & logging stack (Prometheus, Grafana, Loki, CloudWatch)
├── scripts/        # Helper automation scripts
├── serverless/     # Lambda + API Gateway serverless services
└── terraform/      # Core infrastructure as code
```

*Recruiter takeaway: this repo is **organized like a real production platform**, not just a toy project.*

---

## 🧩 Key Components

* **Terraform** → VPC, EKS, RDS, IAM, autoscaling, networking
* **Argo CD** → GitOps continuous delivery for Kubernetes apps
* **CI/CD** → Build and deploy automation (Docker, CodePipeline, GitHub Actions)
* **Docker** → Standardized builds for all microservices
* **Serverless** → Event-driven Lambdas for ETL and lightweight APIs
* **Observability** → Prometheus metrics, Grafana dashboards, Loki logs, CloudWatch integration
* **MLOps** → Placeholder workflows for future ML/AI adoption

---

## 🚀 Example Developer Workflow

1. **Provision infra with Terraform**

   ```bash
   cd terraform/environments/dev
   terraform init && terraform apply
   ```

2. **Deploy apps with Argo CD**

   ```bash
   kubectl apply -f argocd/app-of-apps.yaml
   ```

3. **Build & push a microservice**

   ```bash
   docker build -t <ECR_REPO>/mallhive-user:latest -f docker/user.dockerfile .
   docker push <ECR_REPO>/mallhive-user:latest
   ```

   Argo CD automatically syncs changes into Kubernetes.

---

## 📊 Data & Analytics (ETL)

* **Problem**: Business teams needed near real-time insights from customer activity.
* **Solution**: Event-driven ETL with **Kinesis + Lambda + S3/Redshift**.
* **Result**: Streamed events power analytics dashboards and recommendation models.

---

## 🔍 Observability

* **Problem**: Debugging distributed microservices without visibility is painful.
* **Solution**: Unified observability stack → **Prometheus (metrics)**, **Grafana (dashboards)**, **Loki (logs)**, **CloudWatch exporters**.
* **Result**: Faster incident resolution, proactive monitoring.

---

## 🛡️ Security

* IAM least privilege across services
* Secrets in **AWS Secrets Manager / SSM**
* **KMS encryption** for sensitive data
* **Kyverno** policies for Kubernetes pod security and image signing

---

## 📌 Future Improvements

* [ ] Add service mesh (Istio/Linkerd) for traffic shaping & resilience
* [ ] Integrate **OpenTelemetry** for distributed tracing
* [ ] Expand MLOps workflows for production ML models
* [ ] Harden CI/CD pipelines with artifact signing

---