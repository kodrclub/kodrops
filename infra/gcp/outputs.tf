
output cluster_master_version { value = module.gke.cluster_master_version }
output cluster_node_version { value = module.gke.cluster_node_version }

output cert_manager_version { value = module.cert_manager.version }
output ingress_version { value = module.ingress.version }
output public_ips { value = module.ingress.public_ips }

output prometheus_chart_version { value = module.monitoring.prometheus_chart_version }
output grafana_chart_version { value = module.monitoring.grafana_chart_version }

# output name_servers {value = module.dns.name_servers}
