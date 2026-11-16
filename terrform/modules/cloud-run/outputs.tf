output "service_name" {
  description = "Cloud Run service name"
  value       = google_cloud_run_v2_service.cloud_run_service.name
}

output "service_uri" {
  description = "Cloud Run service HTTPS URL"
  value       = google_cloud_run_v2_service.cloud_run_service
}

output "service_account_email" {
  description = "Cloud Run service account email"
  value       = google_service_account.cloud_run_service_account
}