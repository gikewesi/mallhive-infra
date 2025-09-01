variable "vpc_id" {
  description = "VPC ID where the security groups will be created"
  type        = string
}

variable "trusted_sg_ids" {
  description = "List of trusted Security Group IDs (e.g., EKS worker SGs, Fargate SGs, ETL SGs)"
  type        = list(string)
}

variable "tags" {
  description = "Tags to apply to all security groups"
  type        = map(string)
  default     = {}
}
