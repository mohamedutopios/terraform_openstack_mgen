variable "global_network" {
  description = "Le nom du réseau OpenStack (ex: demo-net, public)"
  type        = string
  default     = "demo-net" # Valeur par défaut si rien n'est spécifié
}

variable "std_image" {
  description = "L'image standard à utiliser pour les serveurs (ex: Ubuntu, Cirros)"
  type        = string
  default     = "cirros" # ou "ubuntu-22.04"
}

variable "key_pair_name" {
  description = "Nom de la clé SSH existante dans OpenStack"
  type        = string
  default     = "mykey"
}