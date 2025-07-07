variable "project" {
  description = "ID du projet GCP"
  type        = string
}

variable "region" {
  description = "Région GCP"
  type        = string
  default     = "europe-west1"
}

variable "zone" {
  description = "Zone GCP"
  type        = string
  default     = "europe-west1-b"
}

variable "my_ip" {
  description = "Adresse IP autorisée pour SSH (CIDR)"
  type        = string
}

variable "ssh_pub_key_path" {
  description = "Chemin de la clé publique SSH"
  type        = string
}
