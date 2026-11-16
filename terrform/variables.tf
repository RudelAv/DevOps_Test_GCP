variable "project_id" {
  description = "Google cloud Project ID"
  type        = string
}

variable "region" {
  description = "Google cloud deployment region"
  type        = string
  default     = "us-central1"
}

variable "environment" {
  description = "Deployment envinonment"
  type        = string
  default     = "dev"
}

# cloud sql modules variales
variable "sql_instance_name" {
  description = "Cloud SQL instance name"
  type        = string
  default     = "php-app-mysql"
}

variable "sql_tier" {
  description = "Cloud SQL machine tier"
  type        = string
  default     = "db-f1-micro"
}

variable "sql_disk_size" {
  description = "Cloud SQL initial disk size"
  type        = number
  default     = 10
}

variable "database_name" {
  description = "Application database name"
  type        = string
  default     = "php_application"
}

variable "database_user" {
  description = "Application database user"
  type        = string
  default     = "php_app_user"
}

variable "database_password" {
  description = "Application database password"
  type        = string
  sensitive   = true
}

# cloud storage variables
variable "static_bucket_name" {
  description = "Cloud Storage bucket for static application files"
  type        = string
}

# Artifact Registry variables
variable "artifact_repository_name" {
  description = "Artifact Registry repository name"
  type        = string
  default     = "php-devops-repo"
}

# Secret Manager variables
variable "database_password_secret_id" {
  description = "Secret Manager ID for the database password"
  type        = string
  default     = "php-devops-db-password"
}