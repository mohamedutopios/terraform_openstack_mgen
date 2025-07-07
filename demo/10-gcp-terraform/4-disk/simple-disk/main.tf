resource "google_compute_disk" "demo_disk" {
  name  = "demo-disk"
  type  = "pd-ssd"           
  zone  = "europe-west1-b"
  size  = 20                 

  labels = {
    environment = "demo"
    owner       = "mohamed"
  }
}
