variable "instance_name" {
  description = "Cloud SQL instance name"
  type        = string
}

variable "region" {
  description = "Google cloud deployment region"
  type        = string
}

variable "tier" {
  description = "Cloud SQL instance tier"
  type        = string
}

variable "disk_size" {
  description = "Cloud SQL instance disk size in GB"
  type        = number
  default     = 10
}

variable "database_version" {
  description = "Cloud SQL instance database version"
  type        = string
}

variable "database_name" {
  description = "Cloud SQL database name"
  type        = string
}

variable "database_user" {
  description = "Cloud SQL database user"
  type        = string
}

variable "database_password" {
  description = "Cloud SQL database password"
  type        = string
  sensitive   = true
}