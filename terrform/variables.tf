variable "project_id" {
    description = "Google cloud Project ID"
    type = string
}

variable "region" {
    description = "Google cloud deployment region"
    type = string
    default = "us-central1"
}

variable "environment" {
    description = "Deployment envinonment"
    type = string
    default = "dev"
}