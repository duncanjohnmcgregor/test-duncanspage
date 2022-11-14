module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "5.2.0"
  project_id = "${var.host_project}"
  network_name = "main-vpc"
  routing_mode = "GLOBAL"
  
  subnets = [
    {
      subnet_name   = "dev-subnet-01"
      subnet_ip     = "10.10.10.0/25"
      subnet_region = "${var.region}"
      description   = "Development workload subnet"
    },
    {
      subnet_name   = "shared-service-subnet-01"
      subnet_ip     = "10.10.10.128/25"
      subnet_region = "${var.region}"
      description   = "Shared service subnet"
    }
  ]

}

# enable compute engine networking api
resource "google_project_service" "compute_api" {
  service = "compute.googleapis.com"
  disable_on_destroy = false
  project = "${var.host_project}"
  
}

# reserve IP range for cloud build worker pool
resource "google_compute_global_address" "worker_range" {
  name          = "cloud-build-worker-pool-range"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = module.vpc.network_id
  depends_on = [google_project_service.compute_api]
  project = "${var.host_project}"
}

# enable service networking api
resource "google_project_service" "servicenetworking" {
  service = "servicenetworking.googleapis.com"
  disable_on_destroy = false
  project = "${var.host_project}"
}

# establish peering link between VPC and cloud build
resource "google_service_networking_connection" "worker_pool_conn" {
  network                 = module.vpc.network_id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.worker_range.name]
  depends_on              = [google_project_service.servicenetworking]
}
