
output "bucket_name" {
  description = "Cloud Storage bucket name"
  value       = google_storage_bucket.static.name
}

output "bucket_url" {
  description = "Cloud Storage bucket URL"
  value       = google_storage_bucket.static.url
}

output "bucket_self_link" {
  description = "Cloud Storage bucket resource URL"
  value       = google_storage_bucket.static.self_link
}
