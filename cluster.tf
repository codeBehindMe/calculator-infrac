variable "project_name" {
  type = string
}
variable "geo_zone" {
  type = string
}

provider "google" {
  credentials = file("maker.json")
  project = var.project_name
}

provider "google-beta" {
  credentials = file("maker.json")
  project = var.project_name
}

resource "google_container_cluster" "test" {
  name = "test"
  provider = google-beta
  location = var.geo_zone

  initial_node_count = 3

  addons_config {
    istio_config {
      disabled = false
      auth = "AUTH_MUTUAL_TLS"
    }
  }
}