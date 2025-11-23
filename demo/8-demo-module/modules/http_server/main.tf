terraform {
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
    }
  }
}

# Création d'un Security Group spécifique pour ce module
resource "openstack_networking_secgroup_v2" "web_sg" {
  name        = "sg_web_${var.env_name}"
  description = "Security group pour serveur web ${var.env_name}"
}

resource "openstack_networking_secgroup_rule_v2" "http_rule" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 80
  port_range_max    = 80
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.web_sg.id
}

# Création de l'instance
resource "openstack_compute_instance_v2" "web_instance" {
  name            = "srv-web-${var.env_name}"
  image_name      = var.image_name
  flavor_name     = var.flavor_name
  security_groups = ["default", openstack_networking_secgroup_v2.web_sg.name]

  network {
    name = var.network_name
  }

  # Script de démarrage (Cloud-init) pour installer Apache
  user_data = <<-EOF
    #!/bin/bash
    apt-get update
    apt-get install -y apache2
    echo "<h1>Site Web - Environnement : ${var.env_name}</h1>" > /var/www/html/index.html
    systemctl start apache2
    systemctl enable apache2
  EOF
}