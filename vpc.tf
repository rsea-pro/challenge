resource "google_compute_network" "vpc" {
  name                            = "dev-network"
  auto_create_subnetworks         = false
}

resource "google_compute_subnetwork" "dev-mgmt" {
  name                     = "dev-mgmt"
  ip_cidr_range            = "10.5.0.0/24"
  region                   = local.region
  network                  = google_compute_network.vpc.id
  private_ip_google_access = true
  stack_type               = "IPV4_ONLY"
}

resource "google_compute_subnetwork" "dev-webserver" {
  name                     = "dev-webserver"
  ip_cidr_range            = "10.8.0.0/24"
  region                   = local.region
  network                  = google_compute_network.vpc.id
  private_ip_google_access = true
  stack_type               = "IPV4_ONLY"

  secondary_ip_range {
    range_name    = "k8s-pods"
    ip_cidr_range = "10.0.0.0/16"
  }

  secondary_ip_range {
    range_name    = "k8s-services"
    ip_cidr_range = "10.4.0.0/20"
  }
}

resource "google_compute_firewall" "allow_iap_ssh" {
  name    = "allow-iap-ssh"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["35.235.240.0/20"]
}