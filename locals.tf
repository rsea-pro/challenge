locals {
  project_id = "useful-academy-449723-v7"
  region     = "us-central1"
  apis = [
    "compute.googleapis.com",
    "container.googleapis.com",
    "logging.googleapis.com",
    "secretmanager.googleapis.com"
  ]
}

resource "google_project_service" "api" {
  for_each = toset(local.apis)
  service  = each.key

  disable_on_destroy = false
}