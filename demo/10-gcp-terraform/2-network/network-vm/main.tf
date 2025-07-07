# VPC Network
resource "google_compute_network" "vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
}

# Subnet - Europe
resource "google_compute_subnetwork" "subnet_eu" {
  name          = var.subnet_eu_name
  ip_cidr_range = var.subnet_eu_cidr
  region        = "europe-west1"
  network       = google_compute_network.vpc.id
}

# Subnet - US
resource "google_compute_subnetwork" "subnet_us" {
  name          = var.subnet_us_name
  ip_cidr_range = var.subnet_us_cidr
  region        = "us-central1"
  network       = google_compute_network.vpc.id
}

# Firewall - Allow SSH
resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ssh"]
}

# Firewall - Allow HTTP
resource "google_compute_firewall" "allow_http" {
  name    = "allow-http"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["http"]
}

# VM Instance
resource "google_compute_instance" "vm_web" {
  name         = "web-vm"
  machine_type = "e2-micro"
  zone         = var.zone

  tags = ["ssh", "http"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.subnet_eu.name

    access_config {} # IP publique automatique
  }

  metadata = {
    ssh-keys = "debian:${file("~/.ssh/id_rsa.pub")}"
  }
}
