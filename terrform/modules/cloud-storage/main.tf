resource "google_storage_bucket" "static" {
  name          = var.bucket_name
  location      = var.location
  storage_class = "STANDARD"

  # manage IAM permissions
  uniform_bucket_level_access = true

  public_access_prevention = "enforced"

  # keeps old version of objects
  versioning {
    enabled = true
  }

  force_destroy = false
}