variable "project_id" {
  type = string
}

variable "vpc_name" {
  type = string
}

variable "zone" {
  type    = string
  default = "europe-west1-b"
}

variable "ssh_public_key_path" {
  type    = string
  default = "~/.ssh/id_rsa.pub"
}
