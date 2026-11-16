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