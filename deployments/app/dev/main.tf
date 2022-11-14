resource "google_compute_instance" "backend" {
  name         = "my-frontend-instance"
  machine_type = "n1-standard-1"
  zone         = "${var.region}-a"
  project      = var.app_project
  tags         = ["backend"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    subnetwork = data.terraform_remote_state.networking-dev.outputs.app_subnet
  }
}