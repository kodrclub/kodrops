resource "google_storage_bucket" "state_bucket" {
  name          = "${var.project_id}-terraform"
  location      = "EU"
  force_destroy = true
}

resource "google_storage_bucket_object" "state_dir" {
  name          = "terraform/state"
  content       = "lorem ipsum"
  bucket        = google_storage_bucket.state_bucket.name
}

