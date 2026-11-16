
output "repository_id" {
  description = "Artifact Registry repository ID"
  value       = google_artifact_registry_repository.docker.repository_id
}

# Output for the Docker repository URL
output "repository_url" {
  description = "Docker repository URL"
  value       = "${google_artifact_registry_repository.docker.location}-docker.pkg.dev/${google_artifact_registry_repository.docker.project}/${google_artifact_registry_repository.docker.repository_id}"
}

output "repository_name" {
  description = "Full Artifact Registry resource name"
  value       = google_artifact_registry_repository.docker.name
}
