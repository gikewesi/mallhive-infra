# 🏗️ MallHive Infrastructure

This repository contains infrastructure code and deployment automation for the MallHive e-commerce platform. It provisions cloud-native resources, defines GitOps configurations, and manages CI/CD pipelines for application and infrastructure.

---

## 📁 Repo Structure

```plaintext
mallhive-infra/
├── argocd/                   # Argo CD Application and AppProject definitions
├── kubernetes/               # Kubernetes manifests and overlays per environment
├── scripts/                  # Helper scripts for bootstrap, setup, and automation
├── terraform/                # Terraform modules and environments
│   ├── networking/
│   ├── eks/
│   └── etl/                  # Infra for the ETL pipeline (Kinesis, Lambda, etc.)
│
├── etl-pipeline/             # ETL pipeline logic and deployment
│   ├── lambda/               # Lambda function source code (e.g., processor.go)
│   └── README.md
│
├── codepipeline/             # AWS CloudFormation for CodePipeline + CodeBuild
│   └── mallhive-pipeline.yaml
│
├── codebuild/                # CodeBuild buildspecs for each pipeline stage
│   ├── buildspec-terraform.yml
│   ├── buildspec-etl-lambda.yml
│   ├── buildspec-k8s-deploy.yml
│   └── buildspec-argocd-sync.yml
│
├── ci/                       # Jenkins pipelines
│   ├── shared/
│   ├── etl/                  # Jenkins pipeline for ETL (terraform + lambda)
│   ├── eks/                  # Jenkins pipeline for EKS provisioning
│   └── global.Jenkinsfile  
│
├── .github/                  # GitHub Actions workflows
│   └── workflows/
│       └── etl-pipeline.yml
│
├── .gitignore
└── README.md
````

---

## 🔧 Getting Started

### Prerequisites

* AWS CLI configured and IAM permissions
* `kubectl`, `kustomize`, and Terraform v1.5+
* Argo CD (optional)
* Jenkins agent (optional)
* GitHub Actions (enabled on repo)

---

## 🚀 Infrastructure Setup

### 1. Provision Infrastructure with Terraform

```bash
cd terraform/environments/dev
terraform init
terraform plan
terraform apply
```

---

### 2. Bootstrap Argo CD (Optional)

```bash
bash scripts/install-argocd.sh
kubectl apply -f argocd/
```

---

### 3. Deploy Services to Kubernetes

```bash
cd kubernetes/user-service/overlays/dev
kustomize build . | kubectl apply -f -
```

---

## 📊 ETL Pipeline

MallHive includes an event-driven ETL system for platform analytics. Events from services (user behavior, transactions, etc.) are streamed into AWS Kinesis, processed via AWS Lambda, and stored in Redshift or S3.

**Relevant Paths:**

* `terraform/etl/`: Infra setup for Kinesis, Lambda, IAM
* `etl-pipeline/lambda/`: Go-based Lambda transformation logic
* `ci/etl/`: Jenkinsfile for ETL deployment
* `.github/workflows/etl-pipeline.yml`: GitHub CI pipeline

**Deployment Manual Steps (if not using CI):**

```bash
cd terraform/etl
terraform apply

cd ../../etl-pipeline/lambda
GOOS=linux GOARCH=amd64 go build -o bootstrap main.go
zip function.zip bootstrap

aws lambda update-function-code \
  --function-name mallhive-etl-transformer \
  --zip-file fileb://function.zip
```

---

## ⚙️ CI/CD Pipelines

### ✅ AWS CodePipeline + CodeBuild

CloudFormation setup is under `codepipeline/mallhive-pipeline.yaml`. It creates:

* GitHub source stage
* Terraform infra apply stage
* Lambda ETL deploy stage
* Kubernetes deploy stage
* ArgoCD sync stage

To deploy it:

```bash
aws cloudformation deploy \
  --template-file codepipeline/mallhive-pipeline.yaml \
  --stack-name mallhive-infra-pipeline \
  --parameter-overrides \
      GitHubOwner=your-github-org \
      GitHubRepo=mallhive-infra \
      GitHubToken=ghp_xxx... \
      ArtifactBucketName=mallhive-pipeline-artifacts \
  --capabilities CAPABILITY_NAMED_IAM
```

### 🔧 CodeBuild Specs (in `codebuild/`)

* `buildspec-terraform.yml`: Init, plan, apply Terraform
* `buildspec-etl-lambda.yml`: Build & deploy ETL Lambda
* `buildspec-k8s-deploy.yml`: Kustomize and apply Kubernetes manifests
* `buildspec-argocd-sync.yml`: Argo CD sync using CLI

### 🧩 GitHub Actions

`.github/workflows/etl-pipeline.yml`: Alternative to Jenkins for ETL deployment.

### 🔁 Jenkins

CI pipelines also supported via Jenkins:

* `ci/etl/`: ETL deployment
* `ci/eks/`: EKS provisioning
* `ci/shared/`: Reusable Groovy logic
* `global.Jenkinsfile`: Entry point if needed

---

## 🛡️ Security Notes

* Use AWS Secrets Manager for GitHub tokens, Terraform vars, etc.
* Least-privilege IAM roles for Lambda and CodeBuild
* Use KMS for encrypting artifacts and secrets

---

## ✍️ Contributions

Infra evolves. Feel free to fork, PR, or open issues if something’s off or missing.

---

## 🧪 Testing Pipelines (Optional)

To test changes without breaking prod:

```bash
# Clone and checkout test branch
git checkout -b test-ci

# Push to trigger GitHub Actions or CodePipeline
git push origin test-ci
```

---
