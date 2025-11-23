variable "env_name" {
  description = "Nom de l'environnement (dev, prod, test)"
  type        = string
}

variable "image_name" {
  description = "Nom de l'image OpenStack à utiliser"
  type        = string
}

variable "flavor_name" {
  description = "Taille de l'instance"
  type        = string
}

variable "network_name" {
  description = "Nom du réseau sur lequel brancher la VM"
  type        = string
}