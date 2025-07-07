variable "project_id" {
  type        = string
  description = "ID du projet GCP"
}

variable "region" {
  type        = string
  default     = "europe-west1"
}

variable "zone" {
  type        = string
  default     = "europe-west1-b"
}

variable "vpc_name" {
  type        = string
  default     = "custom-vpc"
}

variable "subnet_eu_name" {
  type        = string
  default     = "subnet-europe"
}

variable "subnet_eu_cidr" {
  type        = string
  default     = "10.10.0.0/24"
}

variable "subnet_us_name" {
  type        = string
  default     = "subnet-us"
}

variable "subnet_us_cidr" {
  type        = string
  default     = "10.20.0.0/24"
}
