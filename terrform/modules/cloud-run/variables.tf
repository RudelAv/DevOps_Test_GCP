variable "project_id" {
  description = "GCP project ID"
  type        = string

}

variable "region" {
  description = "Cloud Run region"
  type        = string
}

variable "service_name" {
  description = "Cloud Run service name"
  type        = string
}

variable "container_image" {
  description = "Docker image URL"
  type        = string

}

variable "cloud_sql_connection_name" {
  description = "Cloud SQL connection name"
  type        = string

}

variable "database_name" {
  description = "Application database name"
  type        = string
}

variable "database_user" {
  description = "Application database user"
  type        = string
}

variable "database_password_secret_id" {
  description = "Secret Manager secret ID for the database password"
  type        = string
}

variable "static_bucket_name" {
  description = "Cloud Storage bucket for static application files"
  type        = string
}

variable "max_instance_count" {
  description = "Maximum number of Cloud Run instances"
  type        = number
  default     = 2
}