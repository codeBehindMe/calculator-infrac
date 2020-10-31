resource "google_compute_network" "kube_network"{
  name = "kube-network"
  auto_create_subnetworks = false
  routing_mode = "REGIONAL"
}

resource "google_compute_subnetwork" "kube_subnet" {
  ip_cidr_range = "10.152.0.0/16"
  name = "kube-subnet"
  network = google_compute_network.kube_network.id
  region = "australia-southeast1"

}
