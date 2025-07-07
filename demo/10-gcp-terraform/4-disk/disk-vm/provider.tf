terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "6.42.0"
    }
  }
}

provider "google" {
  project = "avid-phoenix-464816-f4"
  region  = "us-central1"
  zone    = "us-central1-c"
  credentials = "keys.json"
}