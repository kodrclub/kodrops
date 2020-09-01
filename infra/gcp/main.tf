#
# Providers
#
provider "google" {
  # See https://github.com/hashicorp/terraform-provider-google/blob/master/CHANGELOG.md
  version     = "~> 3.34"
  project     = var.project_id
  region      = var.main_region
  zone        = var.main_zone
}

provider "dnsimple" {
  token   = var.dnsimple_token
  account = var.dnsimple_account
}

provider "kubernetes" {
  version = "~> 1.12"
  load_config_file       = false
  host                   = module.gke.endpoint
  token                  = module.gke.token
  cluster_ca_certificate = module.gke.cluster_ca_certificate
}

provider "helm" {
  version = "~> 1.2.4"
  kubernetes {
    load_config_file       = false
    host                   = module.gke.endpoint
    token                  = module.gke.token
    cluster_ca_certificate = module.gke.cluster_ca_certificate
  }
}



#
# State
#
terraform {
  backend "gcs" {
    # bucket = "${var.project_id}-terraform"     #created in bootstrap
    bucket = "kodrops-terraform"     #created in bootstrap, but no vars are allowed here #TODO: look into using vars to specify backend bucket name
    prefix = "terraform/state"
  }
}




#
# GKE Cluster
#
module "gke" {
  source                  = "./modules/gke"
  cluster_location        = var.main_zone
  cluster_name            = var.cluster_name
  cluster_pool_node_count = var.cluster_pool_node_count
  k8s_version_prefix      = var.k8s_version_prefix
}

#
# Ingress-nginx
#
module "ingress" {
  source          = "./modules/k8s-ingress"
  ingress_name    = var.cluster_name
  ingress_version = var.ingress_version
}

#
# cert-manager
#
module "cert_manager" {
  source               = "./modules/k8s-cert-manager"
  cert_manager_version = var.cert_manager_version
}

#
# monitoring
#
module "monitoring" {
  source             = "./modules/k8s-monitoring"
  monitoring_name    = var.cluster_name
  grafana_chart_version    = var.grafana_chart_version
  prometheus_chart_version = var.prometheus_chart_version
}

#
# DNSimple
#
module "dnsimple" {
  source       = "./modules/dnsimple"
  domain_name  = var.domain_name
  subdomains   = var.subdomains
  ip           = module.ingress.public_ips.0

  depends_on = [module.ingress.public_ips]
}




