provider "openstack" {
  auth_url    = var.auth_url
  region      = var.region
  tenant_name = var.tenant_name
  user_name   = var.user_name
  password    = var.password
  domain_name = var.domain_name
}

resource "openstack_networking_network_v2" "net" {
  name           = var.network_name
  admin_state_up = true
}

resource "openstack_networking_subnet_v2" "subnet" {
  name            = var.subnet_name
  network_id      = openstack_networking_network_v2.net.id
  cidr            = var.subnet_cidr
  ip_version      = 4
  dns_nameservers = var.dns_nameservers
}

resource "openstack_compute_keypair_v2" "keypair" {
  name       = var.keypair_name
  public_key = file(var.public_key_path)
}

resource "openstack_compute_instance_v2" "vm" {
  count         = var.vm_count
  name          = "${var.vm_name_prefix}-${count.index + 1}"
  image_name    = var.image_name
  flavor_name   = var.flavor_name
  key_pair      = openstack_compute_keypair_v2.keypair.name
  security_groups = ["default"]

  network {
    uuid = openstack_networking_network_v2.net.id
  }
}
