resource "google_container_node_pool" "general" {
  name    = "dev-pool"
  cluster = google_container_cluster.gke.id

  autoscaling {
    total_min_node_count = 1
    total_max_node_count = 4
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  node_config {
    preemptible  = false
    machine_type = "e2-standard-4"

    labels = {
      role = "dev"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
