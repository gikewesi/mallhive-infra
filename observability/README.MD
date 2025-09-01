# Kubernetes & Infrastructure Observability

This folder contains a **unified observability stack** for monitoring the Kubernetes cluster (EKS on Fargate) and its underlying AWS infrastructure.  
The goal is to have **one Grafana instance** showing metrics, logs, and traces for both the control plane and workloads.

---

## 📂 Folder Structure

```

monitoring/
│
├── cloudwatch/          # CloudWatch metrics & logs export configs
├── prometheus/          # Prometheus Operator or Helm chart configs
├── grafana/             # Single Grafana deployment with all dashboards
├── loki/                # Centralized log collection (optional if using CW only)
├── tempo/               # Tracing (optional if you later want traces)
└── exporters/           # Node, kube-state, custom exporters configs

```

---

## 🔄 Flow and Interactions

### **1. Control Plane Monitoring**
**Goal:** Track the health and performance of Kubernetes control plane components (API server, scheduler, controller manager, etc.).

**Flow:**
1. **EKS Control Plane Metrics** → AWS automatically sends these to **CloudWatch** when enabled in EKS logging settings.
2. **CloudWatch** → Metrics are scraped/exported to **Prometheus** using `cloudwatch_exporter` or Prometheus remote write.
3. **Prometheus** stores these metrics.
4. **Grafana** queries Prometheus for visualization (dashboards like API latency, scheduler health, etc.).

**Logs:**
- Control plane logs (API server, audit, authenticator, scheduler, controller manager) are pushed directly to **CloudWatch Logs** by EKS.
- These can be:
  - Viewed directly in **CloudWatch Logs Insights**
  - Or shipped to **Loki** for centralized log search in Grafana.

---

### **2. Workload & Node (Fargate) Monitoring**
**Goal:** Monitor Pods, namespaces, and resources provisioned in each Fargate profile.

**Flow:**
1. **Prometheus** (running in EKS) scrapes:
   - `kube-state-metrics` (cluster object states)
   - `cAdvisor` (container runtime metrics; limited on Fargate)
   - `node-exporter` (limited for Fargate, but some runtime metrics still available)
2. **Prometheus** stores these metrics.
3. **Grafana** visualizes:
   - Pod CPU/memory usage
   - Namespace resource usage
   - Pod restart counts
   - Pending pod durations

**Logs:**
- **Fluent Bit** (or AWS-for-EKS logging) collects Pod logs from `stdout`/`stderr`.
- Logs sent to:
  - **CloudWatch Logs** (AWS-native)
  - **Grafana Loki** (optional for searching logs alongside metrics in Grafana)

---

### **3. Visualization Layer**
**Grafana** is the single pane of glass for:
- **Prometheus** → Cluster & workload metrics
- **Loki** → Pod and system logs
- **Tempo** (or AWS X-Ray) → Traces
- **CloudWatch** → AWS infrastructure metrics

**Dashboards include:**
- Cluster Health (control plane & API latency)
- Namespace Usage (per microservice namespace)
- Node/Fargate Resource Usage
- Pod Lifecycle (restarts, pending pods, crash loops)
- Network & Events Timeline

---

## 📊 Monitoring Scope

### **Metrics**
- API server request latency & error rates
- Scheduler performance
- Controller manager queue lengths
- Pod CPU/memory usage per namespace
- Cluster-wide CPU/memory limits vs requests
- Network traffic between namespaces
- Pending pods and scheduling delays
- Fargate profile resource usage

### **Logs**
- Control plane logs: API server, audit, authenticator
- Pod logs (`stdout`/`stderr`)
- Node logs (runtime events)
- Kubernetes events (deployment changes, pod failures)

### **Traces** (Optional)
- Control plane request traces (API server interactions)
- Network path traces (service-to-service at infra level)
- Event timing (from pod creation to running)

---

## 🚀 Deployment Order

1. **CloudWatch Configs**  
   - Enable EKS control plane logging in AWS Console or via CLI.
   - Set up CloudWatch metrics export configs in `cloudwatch/`.

2. **Prometheus & Exporters**  
   - Deploy Prometheus (Helm or Operator) from `prometheus/`.
   - Deploy exporters from `exporters/`:
     - `kube-state-metrics`
     - `node-exporter`
     - Any custom AWS resource exporters.

3. **Grafana**  
   - Deploy Grafana from `grafana/`.
   - Add datasources:
     - Prometheus
     - CloudWatch
     - Loki (if using)

4. **Logs (Optional Loki)**  
   - Deploy Loki from `loki/`.
   - Configure Fluent Bit or Promtail for log shipping.


---

## 📚 References
- [Amazon EKS Control Plane Logging](https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html)
- [CloudWatch Container Insights](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/Container-Insights.html)
- [Prometheus Operator](https://github.com/prometheus-operator/prometheus-operator)
- [Grafana Loki](https://grafana.com/oss/loki/)
- [Grafana Tempo](https://grafana.com/oss/tempo/)
```

---
