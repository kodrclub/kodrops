# Retrieve an access token as the Terraform runner
data "google_client_config" "provider" {}

# get available k8s version closest to desired
data "google_container_engine_versions" "kubernetes" {
  version_prefix = var.k8s_version_prefix
}

#create the cluster
resource "google_container_cluster" "k8s" {
  name     = var.cluster_name
  location = var.cluster_location

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count  = 1

  min_master_version  = data.google_container_engine_versions.kubernetes.latest_node_version
}

#create an independent node instance pool to use with the cluster
resource "google_container_node_pool" "k8s_nodes" {
  name_prefix = var.cluster_name
  location    = var.cluster_location
  cluster     = google_container_cluster.k8s.name
  node_count  = var.cluster_pool_node_count
  version     = data.google_container_engine_versions.kubernetes.latest_node_version

  management {
    auto_upgrade = false
  }

  node_config {
    machine_type = "e2-medium"

    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}
