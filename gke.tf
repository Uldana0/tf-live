provider "google" {
  project    = "uldana"
  region     = "us-central1-c"
}

resource "google_service_account" "default" {
  account_id   = var.account_id
  display_name = var.display_name
}

resource "google_container_cluster" "primary" {
  name     = var.gke_name
  location = var.region

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1
  node_config {
    disk_size_gb = 60
  }
}