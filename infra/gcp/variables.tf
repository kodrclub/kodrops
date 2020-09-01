variable "project_name" {}
variable "project_id"   {}
variable "main_region"  {}
variable "main_zone"    {}

variable "cluster_name"            {}
variable "cluster_pool_node_count" {}
variable "k8s_version_prefix"      {}


# variable "dns_zone_name" {}
variable "domain_name"   {}
variable "subdomains"    {}
variable "dnsimple_account" {}
variable "dnsimple_token"   {}


variable "cert_manager_version" {default = ""}
variable "ingress_version" {default = ""}

variable "grafana_chart_version" {default =""}
variable "prometheus_chart_version" {default =""}