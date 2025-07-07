variable "domain_name" {
  description = "Primary domain to secure (e.g. www.mallhive.com)"
  type        = string
}

variable "hosted_zone_id" {
  description = "Route 53 public hosted zone ID for the domain"
  type        = string
}

variable "alt_names" {
  description = "Optional list of Subject Alternative Names"
  type        = list(string)
  default     = []
}
