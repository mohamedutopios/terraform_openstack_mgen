# Réseau
resource "openstack_networking_network_v2" "net1" {
  name           = "net1"
  admin_state_up = true
}

# Sous-réseau
resource "openstack_networking_subnet_v2" "subnet1" {
  name            = "subnet1"
  network_id      = openstack_networking_network_v2.net1.id
  cidr            = "192.168.100.0/24"
  ip_version      = 4
  dns_nameservers = ["8.8.8.8"]
}

# Routeur
resource "openstack_networking_router_v2" "router1" {
  name                = "router1"
  external_network_id = "PUBLIC_NETWORK_ID" # à remplacer par l'ID réel
}

# Interface routeur
resource "openstack_networking_router_interface_v2" "router1_interface" {
  router_id = openstack_networking_router_v2.router1.id
  subnet_id = openstack_networking_subnet_v2.subnet1.id
}

# Clé SSH
resource "openstack_compute_keypair_v2" "mykey" {
  name       = "mykey"
  public_key = file("~/.ssh/id_rsa.pub")
}

# Instance
resource "openstack_compute_instance_v2" "my_vm" {
  name            = "my-vm"
  image_name      = "cirros" # ou ubuntu
  flavor_name     = "m1.small"
  key_pair        = openstack_compute_keypair_v2.mykey.name
  security_groups = ["default"]

  network {
    uuid = openstack_networking_network_v2.net1.id
  }
}

# IP flottante
resource "openstack_networking_floatingip_v2" "fip1" {
  pool = "public" # ou votre réseau externe
}

# Associer IP flottante
resource "openstack_compute_floatingip_associate_v2" "fip_assoc" {
  floating_ip = openstack_networking_floatingip_v2.fip1.address
  instance_id = openstack_compute_instance_v2.my_vm.id
}
