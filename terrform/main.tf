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
        bucket      = "gcp-devops-the-program-470313-k9"
        prefix      = "terraform/state"
    }
}

# google cloud provider

provider "google" {
    project = var.project_id
    region = var.region
}



