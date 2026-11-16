# Secret manager module

resource "google_project_service" "manager_secret" {
  project = var.project_id
  service = "secretmanager.googleapis.com"
  disable_on_destroy = false
}

resource "google_secret_manager_secret" "password_database" {
  project = var.project_id
  secret_id = var.secret_id

  replication {
    auto {}
  }

  depends_on = [ google_project_service.manager_secret ]
}