resource "google_compute_network" "main" {
  name                    = "tp-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet1" {
  name          = "tp-subnet-11"
  ip_cidr_range = "10.11.1.0/24"
  region        = var.region
  network       = google_compute_network.main.id
}

resource "google_compute_subnetwork" "subnet2" {
  name          = "tp-subnet-22"
  ip_cidr_range = "10.11.2.0/24"
  region        = var.region
  network       = google_compute_network.main.id
}

resource "google_compute_subnetwork" "subnet3" {
  name          = "tp-subnet-33"
  ip_cidr_range = "10.11.3.0/24"
  region        = var.region
  network       = google_compute_network.main.id
}

resource "google_compute_firewall" "ssh_bastion" {
  name    = "allow-ssh-bastion"
  network = google_compute_network.main.id
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = [var.my_ip]
  target_tags   = ["bastion"]
}

resource "google_compute_firewall" "internal" {
  name    = "allow-internal"
  network = google_compute_network.main.id
  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["10.11.0.0/16"]
}


locals {
  ssh_user = "debian"
  ssh_key  = file(var.ssh_pub_key_path)
}


resource "google_compute_instance" "vm1" {
  name         = "vm1-bastion"
  machine_type = "e2-micro"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    subnetwork    = google_compute_subnetwork.subnet1.id
    access_config {}
  }

  tags = ["bastion"]

  metadata = {
    ssh-keys = "${local.ssh_user}:${local.ssh_key}"
  }
}


resource "google_compute_instance" "vm2" {
  name         = "vm2"
  machine_type = "e2-micro"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.subnet2.id
  }

  metadata = {
    ssh-keys = "${local.ssh_user}:${local.ssh_key}"
  }
}

resource "google_compute_instance" "vm3" {
  name         = "vm3"
  machine_type = "e2-micro"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.subnet3.id
  }

  metadata = {
    ssh-keys = "${local.ssh_user}:${local.ssh_key}"
  }
}
