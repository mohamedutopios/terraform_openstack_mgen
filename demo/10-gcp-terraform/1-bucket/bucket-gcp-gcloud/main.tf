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
}

resource "google_storage_bucket" "demo-gcp" {
  name          = "demo-gcp-mohamed-mgen"
  location      = "US"
}