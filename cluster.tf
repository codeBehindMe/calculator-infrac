variable "project_name" {
  type = string
}
variable "geo_zone" {
  type = string
}

variable "master_auth_ip_cidr" {
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

resource "google_container_cluster" "calc_cluster" {
  name = "calc-cluster"
  provider = google-beta
  location = var.geo_zone
  network = google_compute_network.kube_network.name
  subnetwork = google_compute_subnetwork.kube_subnet.name

  remove_default_node_pool = true
  initial_node_count = 1

  ip_allocation_policy {
    services_ipv4_cidr_block = "10.1.0.0/20"
    cluster_ipv4_cidr_block = "192.168.0.0/20"
  }

  master_authorized_networks_config {
    cidr_blocks {
      cidr_block = var.master_auth_ip_cidr
    }
  }

  addons_config {
    istio_config {
      disabled = false
      auth = "AUTH_MUTUAL_TLS"
    }
  }
}

resource "google_container_node_pool" "preemptible_nodes_alpha" {
  name = "pe-alpha-pool"
  location = var.geo_zone
  cluster = google_container_cluster.calc_cluster.name
  initial_node_count = 1

  node_locations = [var.geo_zone]
  autoscaling {
    max_node_count = 5
    min_node_count = 1
  }
  node_config {
    preemptible = true
  }
}