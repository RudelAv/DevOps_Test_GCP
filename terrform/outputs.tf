output "project_id" {
  description = "Google cloud Project ID"
  value       = var.project_id
}

output "region" {
  description = "Google cloud deployment region"
  value       = var.region
}

output "environment" {
  description = "Deployment envinonment"
  value       = var.environment
}

# Cloud SQL instance configuration outputs
output "cloud_sql_instance_name" {
  description = "Cloud SQL instance name"
  value       = module.cloud_sql.instance_name
}

output "cloud_sql_connection_name" {
  description = "Cloud SQL connection name"
  value       = module.cloud_sql.connection_name
}

output "cloud_sql_database_name" {
  description = "Application database name"
  value       = module.cloud_sql.database_name
}

output "cloud_sql_public_ip" {
  description = "Cloud SQL public IP"
  value       = module.cloud_sql.public_ip_address
}

# cloud storage configuration outputs

output "cloud_storage_bucket_name" {
  description = "Static files bucket name"
  value       = module.cloud_storage.bucket_name
}

output "cloud_storage_bucket_url" {
  description = "Static files bucket URL"
  value       = module.cloud_storage.bucket_url
}

# Artifact Registry configuration outputs
output "artifact_registry_repository_url" {
  description = "Artifact Registry Docker repository URL"
  value       = module.artifact_registry.repository_url
}

output "artifact_registry_repository_id" {
  description = "Artifact Registry repository ID"
  value       = module.artifact_registry.repository_id
}

# Secret Manager configuration outputs
output "database_password_secret_id" {
  description = "Database password Secret Manager ID"
  value       = module.secret_manager.secret_id
}

output "database_password_secret_name" {
  description = "Full Secret Manager resource name"
  value       = module.secret_manager.secret_name
}

# Cloud Run configuration outputs
output "cloud_run_service_name" {
  description = "Cloud Run service name"
  value       = module.cloud_run.service_name
}

output "cloud_run_service_uri" {
  description = "Cloud Run HTTPS URL"
  value       = module.cloud_run.service_uri
}

output "cloud_run_service_account" {
  description = "Cloud Run service account email"
  value       = module.cloud_run.service_account_email
}