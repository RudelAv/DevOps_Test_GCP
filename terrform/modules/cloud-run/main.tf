#  Enable cloud run API
resource "google_project_service" "cloud_run" {
  project            = var.project_id
  service            = "run.googleapis.com"
  disable_on_destroy = false
}

# dedicated service account for cloud run
resource "google_service_account" "cloud_run_service_account" {
  account_id   = "${var.project_id}-cloudrun"
  display_name = "Service account for Cloud Run"
  project      = var.project_id
}

# Cloud SQL access 
resource "google_project_iam_member" "cloud_run_cloud_sql_access" {
  project = var.project_id
  role    = "roles/cloudsql.client"
  member  = "serviceAccount:${google_service_account.cloud_run_service_account.email}"
}

# Secret Manager access 
resource "google_secret_manager_secret_iam_member" "password_database" {
  secret_id = var.database_password_secret_id
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:${google_service_account.cloud_run_service_account.email}"
}

# cloud Storage access 
resource "google_storage_bucket_iam_member" "cloud_run_storage_access" {
  bucket = var.static_bucket_name
  role   = "roles/storage.objectViewer"
  member = "serviceAccount:${google_service_account.cloud_run_service_account.email}"
}

# cloud run service
resource "google_cloud_run_v2_service" "cloud_run_service" {
  project  = var.project_id
  name     = var.service_name
  location = var.region

  # Temporary public ingress for initial testing.
  ingress = "INGRESS_TRAFFIC_ALL"

  deletion_protection = false

  template {
    service_account = google_service_account.cloud_run_service_account.email

    max_instance_request_concurrency = 80

    scaling {
      max_instance_count = var.max_instance_count
    }

    # Cloud SQL Unix socket integration

    volumes {
      name = "cloudsql"

      cloud_sql_instance {
        instances = [
          var.cloud_sql_connection_name
        ]
      }
    }

    containers {
      image = var.container_image

      ports {
        container_port = 8080
      }

      resources {
        limits = {
          cpu    = "1"
          memory = "512Mi"
        }
      }

      # Database configuration

      env {
        name  = "DB_HOST"
        value = "/cloudsql/${var.cloud_sql_connection_name}"
      }

      env {
        name  = "DB_DATABASE"
        value = var.database_name
      }

      env {
        name  = "DB_USERNAME"
        value = var.database_user
      }

      # Database password from Secret Manager

      env {
        name = "DB_PASSWORD"

        value_source {
          secret_key_ref {
            secret  = var.database_password_secret_id
            version = "latest"
          }
        }
      }

      # Mount Cloud SQL socket

      volume_mounts {
        name       = "cloudsql"
        mount_path = "/cloudsql"
      }
    }
  }

  lifecycle {
    ignore_changes = [
      template[0].containers[0].image
    ]
  }
  depends_on = [
    google_project_service.cloud_run,
    google_project_iam_member.cloud_run_cloud_sql_access,
    google_secret_manager_secret_iam_member.password_database,
    google_storage_bucket_iam_member.cloud_run_storage_access
  ]



}

# Allow unauthenticated HTTP requests for initial testing

resource "google_cloud_run_v2_service_iam_member" "access_public" {
  project  = var.project_id
  location = var.region
  name     = google_cloud_run_v2_service.cloud_run_service.name

  role   = "roles/run.invoker"
  member = "allUsers"
}