# 1. Disque géré par Terraform
resource "google_compute_disk" "attached_disk" {
  name  = "attached-disk"
  type  = "pd-standard"
  zone  = "europe-west1-b"
  size  = 50
}

# 2. Data source pour récupérer un disque déjà existant dans GCP
data "google_compute_disk" "existing_disk" {
  name = "my-existing-disk"      # nom exact du disque existant
  zone = "europe-west1-b"
}

# 3. VM avec deux disques attachés
resource "google_compute_instance" "demo_vm" {
  name         = "demo-vm"
  machine_type = "e2-micro"
  zone         = "europe-west1-b"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  # Premier disque (créé ici)
  attached_disk {
    source      = google_compute_disk.attached_disk.id
    device_name = "data-disk"
  }

  # Second disque (existant déjà dans GCP)
  attached_disk {
    source      = data.google_compute_disk.demo_disk.id
    device_name = "extra-disk"
  }

  network_interface {
    network = "default"
    access_config {}
  }
}


output "attached_disk_id" {
  value = google_compute_disk.attached_disk.id
}

output "existing_disk_id" {
  value = data.google_compute_disk.existing_disk.id
}
