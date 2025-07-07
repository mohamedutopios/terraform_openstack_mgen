locals {
  vm_names = ["web-vm-1", "web-vm-2", "web-vm-3"]
}

locals {
  startup_script_nginx = <<-EOT
#!/bin/bash
apt-get update
apt-get install -y nginx
systemctl start nginx
EOT
}


data "google_compute_subnetwork" "subnet_eu" {
  name   = "subnet-europe"
  region = "europe-west1"
}


resource "google_compute_instance" "web_vms" {
  count        = length(local.vm_names)
  name         = local.vm_names[count.index]
  machine_type = "e2-micro"
  zone         = var.zone

  tags = ["ssh", "http"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    subnetwork = data.google_compute_subnetwork.subnet_eu.self_link != null ? data.google_compute_subnetwork.subnet_eu.self_link  : 
    access_config {}
  }

  metadata = {
    ssh-keys = "debian:${file(var.ssh_public_key_path)}"
  }

 metadata_startup_script = count.index == 0 ? local.startup_script_nginx : null


}