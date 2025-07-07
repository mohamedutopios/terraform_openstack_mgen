variable "environment" {}
variable "location" {}
variable "resource_group_name" {}
variable "vnet_name" {}
variable "subnet_name" {}
variable "address_space" {
  type = list(string)
}
variable "subnet_prefix" {
  type = list(string)
}
variable "admin_username" {}
variable "admin_ssh_key" {
  type = string
}
variable "vm_name" {}
variable "vm_size" {
  default = "Standard_B1s"
}