#
# DO NOT DEFINE SECRETS HERE
#
# Use environment variables in the form TF_VAR_mysecretvarname instead
#
project_name = "kodrops"
project_id   = "kodrops"
main_region  = "europe-west4"
main_zone    = "europe-west4-a"

cluster_name            = "kodrops-xyz"
cluster_location        = "europe-west4" #Specify a region to create a multi-zone cluster. Specify a zone to create a single-zone cluster
cluster_pool_node_count = 2
k8s_version_prefix      = "1.16."

cert_manager_version = "0.16"
ingress_version      = "2.12"

grafana_chart_version    = "5.5"
prometheus_chart_version = "11.12"

# dns_zone_name = "kodrops-xyz"
domain_name = "kodrops.xyz"
subdomains  = ["graf", "prom"]
# dnsimple_account = ---- SECRET ----
# dnsimple_token   = ---- SECRET ----
