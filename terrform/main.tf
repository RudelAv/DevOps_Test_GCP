# Terraform configuration

terraform {
  required_version = ">=1.6.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 7.0"
    }
  }


  # Remote state Backend configuration

  backend "gcs" {
    bucket = "gcp-devops-the-program-470313-k9"
    prefix = "terraform/state"
  }
}

# google cloud provider

provider "google" {
  project = var.project_id
  region  = var.region
}

# Modules

module "cloud_sql" {
  source = "./modules/cloud-sql"

  instance_name     = var.sql_instance_name
  database_version  = "MYSQL_8_0"
  region            = var.region
  tier              = var.sql_tier
  disk_size         = var.sql_disk_size
  database_name     = var.database_name
  database_user     = var.database_user
  database_password = var.database_password
}


