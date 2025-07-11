# 📊 MallHive ETL Pipeline

This repository contains the ETL (Extract, Transform, Load) pipeline for the **Analytics & Reporting** microservice in the [MallHive](https://github.com/gikewesi/mallhive-ecommerce.git) e-commerce platform. It captures and processes user and system events in real time using AWS-native tools.

---

## 📦 Purpose

Enable MallHive to collect behavioral, transactional, and performance events from across the platform, transform them for analytics, and load them into Redshift and/or S3 for reporting and dashboarding.

---

## 📍 Location in Project

- **Event producer**: [`mallhive-ecommerce/micro-services/analytics-service/analystics.go`](https://github.com/gikewesi/mallhive-ecommerce.git)
- **ETL pipeline**: This directory (`mallhive-infra/etl-pipeline/`)

---

## 🚀 Architecture Overview

```text
+--------------------+
|  MallHive Services |
|  (frontend, APIs)  |
+---------+----------+
          |
       POST /events
          |
+---------v----------+
| Analytics Service  |
| (Gin + Kinesis SDK)|
+---------+----------+
          |
   PutRecords (Kinesis)
          |
+---------v----------+
| AWS Kinesis Stream |
+---------+----------+
          |
 Trigger  | 
          v
+-------------------+
|  ETL Lambda (Go)  |
|  or containerized |
|  transformer      |
+-------------------+
          |
   Transform & Clean
          |
   +------+------+
   |             |
   v             v
[S3 Bucket]   [Redshift]
````

---

## 📥 Extract

Handled by the `analytics.go` service.

* Accepts POST requests at `/events`
* Validates and enriches incoming event JSON
* Streams data in batches to `AWS Kinesis`

---

## 🔧 Transform

Handled by a **Lambda function**:

* Parses and normalizes event data
* Enriches metadata (browser, OS, referrer parsing)
* Filters invalid or noisy events
* Optionally performs session aggregation or tagging

---

## 🧱 Load

Transformed data is pushed to:

* **Amazon S3**: For raw or semi-processed events (used with Athena or Glue)
* **Amazon Redshift**: For structured analytics, dashboards, and reporting tools
* **Amazon QuickSight**: For BI and dashboards

---

## 🛠️ Tech Stack

| Component      | Tool/Service         |
| -------------- | -------------------- |
| Event Ingest   | Go (Gin), Kinesis    |
| Transformation | AWS Lambda (Go)      |
| Storage        | S3, Redshift         |
| Orchestration  | CloudWatch, IAM      |
| Infra as Code  | Terraform   
| Dashboarding   | QuickSight 

---

## 🧪 Example Event Payload

```json
{
  "user_id": "u123",
  "event_type": "user_behavior",
  "event_subtype": "product_view",
  "product_id": "p456",
  "category": "electronics",
  "location": "Texas"
  "device_type": "mobile",
  "metadata": {
    "browser": "Chrome",
    "os": "Android",
    "referrer": "facebook.com"
  }
}
```

---

## 🧰 Local Dev Setup

```bash
# Clone the repo
git clone https://github.com/your-org/mallhive-analytics-etl.git
cd mallhive-analytics-etl

# Set environment variables
export AWS_REGION=us-east-2
export KINESIS_STREAM_NAME=analytics-events
export API_KEY=your-api-key

# Run locally
go run analytics.go
```

---

## 🧯 Monitoring & Reliability

* ✅ AWS CloudWatch Logs for both `analytics.go` and ETL Lambda
* ✅ Dead Letter Queue for failed transformations (optional)
* ✅ Alerting via CloudWatch Alarms on stream throttling, Lambda errors, or delivery failures

---

## 📈 Dashboards

* **Athena**: Query events directly from S3
* **Redshift**: Power dashboards with pre-aggregated event tables
* **QuickSight**: Visualize user behavior, conversions, and revenue trends

---

## 📌 TODO

* [ ] Add session duration aggregation
* [ ] Parse and classify traffic sources from UTM parameters
* [ ] Optimize Redshift schema for query performance
* [ ] Terraform automation for full pipeline provisioning

---

## 📄 License

MIT © 2025 MallHive Contributors

```

---

```
