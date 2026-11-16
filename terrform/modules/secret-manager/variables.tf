variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "secret_id" {
  description = "Secret identifier in secret manager"
  type        = string
}

variable "secret_data" {
  description = "Database password stored in Secret Manager"
  type        = string
  sensitive   = true
}