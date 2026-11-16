output "secret_id" {
  description = "Secret Manager secret ID"
  value       = google_secret_manager_secret.password_database
}

output "secret_name" {
  description = "Full Secret Manager resource name"
  value       = google_secret_manager_secret.password_database.name
}