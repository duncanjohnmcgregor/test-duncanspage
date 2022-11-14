terraform {
  backend "gcs" {
    bucket  = "tf-backend-gcs-bucket"
    prefix  = "tf-practice/state-dev/app"
  }
}