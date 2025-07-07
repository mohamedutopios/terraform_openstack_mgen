terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.85.0"
    }
  }
}

provider "google" {
  project = "avid-phoenix-464816-f4"
  region = "us-central1"
  zone = "us-central1-a"
  credentials = "keys.json"
}











