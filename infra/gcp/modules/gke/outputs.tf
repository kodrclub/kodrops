
output cluster_master_version {value = google_container_cluster.k8s.master_version}
output cluster_node_version   {value = google_container_node_pool.k8s_nodes.version}

output token {
  value = data.google_client_config.provider.access_token
  sensitive = true
}

output endpoint {
  value  = google_container_cluster.k8s.endpoint
  depends_on = [
    google_container_cluster.k8s,
    google_container_node_pool.k8s_nodes,
  ]
  sensitive = true
}

output cluster_ca_certificate {
  value = base64decode(
    google_container_cluster.k8s.master_auth[0].cluster_ca_certificate,
  )
  depends_on = [
    google_container_cluster.k8s,
    google_container_node_pool.k8s_nodes,
  ]
  sensitive = true
}