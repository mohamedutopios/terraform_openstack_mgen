variable "create_test_subnet" {
  description = "Create test subnet"
  type = bool
  default = true
}

variable "resource_group_name" {
  description = "name of resource group"
  type = string
  default = "example-resources-group"
}
