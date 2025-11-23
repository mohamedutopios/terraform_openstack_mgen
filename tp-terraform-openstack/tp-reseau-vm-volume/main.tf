data "openstack_networking_network_v2" "external" {
  name     = var.external_network_name
  external = true
}

resource "openstack_images_image_v2" "ubuntu_18" {
  name             = local.ubuntu_18_name
  image_source_url = var.ubuntu_18_url
  container_format = "bare"
  disk_format      = "qcow2"
  web_download     = true
  visibility       = "private"
}

resource "openstack_images_image_v2" "ubuntu_20" {
  name             = local.ubuntu_20_name
  image_source_url = var.ubuntu_20_url
  container_format = "bare"
  disk_format      = "qcow2"
  web_download     = true
  visibility       = "private"
}

resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "private_key" {
  content         = tls_private_key.ssh_key.private_key_pem
  filename        = "${path.module}/${var.ssh_key_name}.pem"
  file_permission = "0600"
}

resource "openstack_compute_keypair_v2" "keypair" {
  name       = var.ssh_key_name
  public_key = tls_private_key.ssh_key.public_key_openssh
}

resource "openstack_networking_network_v2" "network_1" {
  name           = "${var.project_name}-network-1"
  admin_state_up = true
}

resource "openstack_networking_subnet_v2" "subnet_1" {
  name            = "${var.project_name}-subnet-1"
  network_id      = openstack_networking_network_v2.network_1.id
  cidr            = var.subnet_1_cidr
  ip_version      = 4
  dns_nameservers = var.dns_nameservers
}

resource "openstack_networking_network_v2" "network_2" {
  name           = "${var.project_name}-network-2"
  admin_state_up = true
}

resource "openstack_networking_subnet_v2" "subnet_2" {
  name            = "${var.project_name}-subnet-2"
  network_id      = openstack_networking_network_v2.network_2.id
  cidr            = var.subnet_2_cidr
  ip_version      = 4
  dns_nameservers = var.dns_nameservers
}

resource "openstack_networking_router_v2" "router" {
  name                = "${var.project_name}-router"
  admin_state_up      = true
  external_network_id = data.openstack_networking_network_v2.external.id
}

resource "openstack_networking_router_interface_v2" "router_interface_1" {
  router_id = openstack_networking_router_v2.router.id
  subnet_id = openstack_networking_subnet_v2.subnet_1.id
}

resource "openstack_networking_router_interface_v2" "router_interface_2" {
  router_id = openstack_networking_router_v2.router.id
  subnet_id = openstack_networking_subnet_v2.subnet_2.id
}

resource "openstack_networking_secgroup_v2" "sg_vm1" {
  name = "${var.project_name}-sg-vm1"
}

resource "openstack_networking_secgroup_rule_v2" "sg_vm1_ssh" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.sg_vm1.id
}

resource "openstack_networking_secgroup_rule_v2" "sg_vm1_http" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 80
  port_range_max    = 80
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.sg_vm1.id
}

resource "openstack_networking_secgroup_rule_v2" "sg_vm1_icmp" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "icmp"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.sg_vm1.id
}

resource "openstack_networking_secgroup_rule_v2" "sg_vm1_egress" {
  direction         = "egress"
  ethertype         = "IPv4"
  security_group_id = openstack_networking_secgroup_v2.sg_vm1.id
}

resource "openstack_networking_secgroup_v2" "sg_vm2" {
  name = "${var.project_name}-sg-vm2"
}

resource "openstack_networking_secgroup_rule_v2" "sg_vm2_ssh" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = var.subnet_1_cidr
  security_group_id = openstack_networking_secgroup_v2.sg_vm2.id
}

resource "openstack_networking_secgroup_rule_v2" "sg_vm2_icmp" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "icmp"
  remote_ip_prefix  = var.subnet_1_cidr
  security_group_id = openstack_networking_secgroup_v2.sg_vm2.id
}

resource "openstack_networking_secgroup_rule_v2" "sg_vm2_egress" {
  direction         = "egress"
  ethertype         = "IPv4"
  security_group_id = openstack_networking_secgroup_v2.sg_vm2.id
}

resource "openstack_blockstorage_volume_v3" "volume_vm1" {
  name = "${var.project_name}-volume-vm1"
  size = var.volume_size
}

resource "openstack_blockstorage_volume_v3" "volume_vm2" {
  name = "${var.project_name}-volume-vm2"
  size = var.volume_size
}

resource "openstack_compute_instance_v2" "vm1" {
  name            = "${var.project_name}-vm1"
  image_id        = openstack_images_image_v2.ubuntu_18.id
  flavor_name     = var.flavor_name
  key_pair        = openstack_compute_keypair_v2.keypair.name
  security_groups = [openstack_networking_secgroup_v2.sg_vm1.name]

  network {
    uuid = openstack_networking_network_v2.network_1.id
  }

  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y nginx
              systemctl enable nginx
              systemctl start nginx
              EOF

  depends_on = [openstack_images_image_v2.ubuntu_18]
}

resource "openstack_compute_volume_attach_v2" "attach_volume_vm1" {
  instance_id = openstack_compute_instance_v2.vm1.id
  volume_id   = openstack_blockstorage_volume_v3.volume_vm1.id
}

resource "openstack_networking_floatingip_v2" "fip_vm1" {
  pool = data.openstack_networking_network_v2.external.name
}

resource "openstack_compute_floatingip_associate_v2" "fip_vm1_associate" {
  floating_ip = openstack_networking_floatingip_v2.fip_vm1.address
  instance_id = openstack_compute_instance_v2.vm1.id
}

resource "openstack_compute_instance_v2" "vm2" {
  name            = "${var.project_name}-vm2"
  image_id        = openstack_images_image_v2.ubuntu_20.id
  flavor_name     = var.flavor_name
  key_pair        = openstack_compute_keypair_v2.keypair.name
  security_groups = [openstack_networking_secgroup_v2.sg_vm2.name]

  network {
    uuid = openstack_networking_network_v2.network_2.id
  }

  depends_on = [openstack_images_image_v2.ubuntu_20]
}

resource "openstack_compute_volume_attach_v2" "attach_volume_vm2" {
  instance_id = openstack_compute_instance_v2.vm2.id
  volume_id   = openstack_blockstorage_volume_v3.volume_vm2.id
}