# Artifact Registry repository for Docker images

resource "google_artifact_registry_repository" "docker" {
  location      = var.location
  repository_id = var.repository_name
  description   = var.description
  format        = "DOCKER"

}
