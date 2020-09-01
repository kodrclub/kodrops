terraform {
  required_providers {
    dnsimple = {
      source = "terraform-providers/dnsimple"
    }
    google = {
      source = "hashicorp/google"
    }
    helm = {
      source = "hashicorp/helm"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
  required_version = ">= 0.13"
}
