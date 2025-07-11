# MallHive Infrastructure

This repository contains the infrastructure code and Kubernetes deployment configurations for the MallHive e-commerce platform. It handles provisioning of cloud resources, deployment setup, GitOps configurations, and CI/CD pipelines.

---

## 📁 Repo Structure

```plaintext
mallhive-infra/
├── argocd/         # Argo CD Application and AppProject definitions
├── kubernetes/     # Kubernetes manifests and overlays per environment
├── scripts/        # Helper scripts for bootstrap, setup, and automation
├── terraform/      # Infrastructure as Code using Terraform (modular setup)
├── .gitignore      # Git ignored files
├── Jenkinsfile     # CI/CD pipeline for infra changes and deployments
└── README.md       # This file
````

---

## 🔧 Getting Started

### Prerequisites

* AWS CLI configured
* `kubectl` and `kustomize` installed
* Terraform v1.5+
* Argo CD installed on cluster (or use provided script)
* Jenkins or another CI runner (if using Jenkinsfile)

---

## 🚀 Usage

### 1. Provision Infrastructure with Terraform

```bash
cd terraform/environments/dev
terraform init
terraform plan
terraform apply
```

You can switch to `prod/` or `staging/` as needed.

---

### 2. Bootstrap Argo CD (Optional)

If Argo CD is not already installed:

```bash
bash scripts/install-argocd.sh
```

Then apply the Argo CD applications:

```bash
kubectl apply -f argocd/
```

---

### 3. Deploy Services to Kubernetes

Kubernetes manifests are in the `kubernetes/` directory, organized per service and environment.

Example:

```bash
cd kubernetes/user-service/overlays/dev
kustomize build . | kubectl apply -f -
```

---

## 🛠 CI/CD with Jenkins

The `Jenkinsfile` contains a pipeline for:

* Terraform lint and plan
* Kubernetes manifest validation
* Optional apply to environment
* Notifications

You can adjust the pipeline steps based on your team’s process.

---

## 🧪 Environments

* `dev`: Non-prod environment for developers
* `staging`: Pre-prod environment used for testing
* `prod`: Live production environment

Each environment has its own state and configuration in Terraform and Kubernetes overlays.

---

## 📜 License

This project is licensed under your organization’s preferred license.
You can add a `LICENSE` file in the repo if needed.

---

## ✍️ Contributions

Feel free to submit a PR or open issues for bugs or suggestions. Infra evolves, and so should this repo.

```

