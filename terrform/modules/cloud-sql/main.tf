# Cloud SQL MYSQL instance configuration

resource "google_sql_database_instance" "this" {
  name             = var.instance_name
  database_version = var.database_version
  region           = var.region

  deletion_protection = false

  settings {

    tier = var.tier

    # disk configuration
    disk_size       = var.disk_size
    disk_type       = "PD_HDD"
    disk_autoresize = true

    # IPV4 public adress
    ip_configuration {
      ipv4_enabled = true
    }

    backup_configuration {
      enabled = false
    }
  }
}

# Application database

resource "google_sql_database" "database" {
  name     = var.database_name
  instance = google_sql_database_instance.this.name
}

# Application database user

resource "google_sql_user" "user" {
  name     = var.database_user
  instance = google_sql_database_instance.this.name
  password = var.database_password
}