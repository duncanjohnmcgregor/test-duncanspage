resource "google_cloudbuild_worker_pool" "pool" {
  name = "build-pool"
  location = "${var.region}"

  worker_config {
    disk_size_gb = 100
    machine_type = "e2-medium"
    no_external_ip = false
  }

  network_config {
    peered_network = data.terraform_remote_state.networking-dev.outputs.network_vpc_id
  }

  project = "${var.host_project}"
  depends_on = [google_project_service.cloud_build]
}

# enable cloud build api
resource "google_project_service" "cloud_build" {
  service = "cloudbuild.googleapis.com"
  disable_on_destroy = false
  project = "${var.host_project}"
}