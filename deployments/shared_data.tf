data "terraform_remote_state" "networking-dev" {
  backend = "gcs"

  config = {
    bucket = "tf-backend-gcs-bucket"
    prefix = "tf-practice/state-dev/networking"
  }
}