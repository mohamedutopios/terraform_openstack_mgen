variable "auth_url" {
  default = "http://controller:5000/v3"
}

variable "region" {
  default = "RegionOne"
}

variable "tenant_name" {
  default = "admin"
}

variable "user_name" {
  default = "admin"
}

variable "password" {
  default = "admin_password"
}

variable "domain_name" {
  default = "Default"
}

variable "network_name" {
  default = "mynet"
}

variable "subnet_name" {
  default = "mysubnet"
}

variable "subnet_cidr" {
  default = "192.168.200.0/24"
}

variable "dns_nameservers" {
  default = ["8.8.8.8"]
}

variable "keypair_name" {
  default = "mykey"
}

variable "public_key_path" {
  default = "~/.ssh/id_rsa.pub"
}

variable "image_name" {
  default = "cirros"
}

variable "flavor_name" {
  default = "m1.tiny"
}

variable "vm_count" {
  default = 3
}

variable "vm_name_prefix" {
  default = "demo-vm"
}
