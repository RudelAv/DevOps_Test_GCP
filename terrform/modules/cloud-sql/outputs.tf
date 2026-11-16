output "instance_name" {
  description = "Cloud SQL instance name"
  value       = google_sql_database_instance.main.name
}

output "connection_name" {
  description = "Cloud SQL connection name"
  value       = google_sql_database_instance.main.connection_name
}

output "database_name" {
  description = "Cloud SQL database name"
  value       = google_sql_database.database.name
}

output "database_user" {
  description = "Cloud SQL database user"
  value       = google_sql_user.user.name
}

output "public_ip_address" {
  description = "Cloud SQL instance public IP address"
  value       = google_sql_database_instance.main.public_ip_address
}