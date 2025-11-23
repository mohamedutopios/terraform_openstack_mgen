variable "project_name" {
  type    = string
  default = "admin"
}

variable "external_network_name" {
  type    = string
  default = "public1"
}

variable "ubuntu_18_url" {
  type    = string
  default = "https://cloud-images.ubuntu.com/bionic/current/bionic-server-cloudimg-amd64.img"
}

variable "ubuntu_20_url" {
  type    = string
  default = "https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.img"
}

variable "flavor_name" {
  type    = string
  default = "m1.small"
}

variable "ssh_key_name" {
  type    = string
  default = "terraform-key"
}

variable "subnet_1_cidr" {
  type    = string
  default = "192.168.1.0/24"
}

variable "subnet_2_cidr" {
  type    = string
  default = "192.168.2.0/24"
}

variable "dns_nameservers" {
  type    = list(string)
  default = ["8.8.8.8", "8.8.4.4"]
}

variable "volume_size" {
  type    = number
  default = 10
}