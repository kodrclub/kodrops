resource kubernetes_namespace cert_manager_ns{
  metadata{
    name = "cert-manager"
  }
}
resource helm_release cert_manager {
  name = "cert-manager"
  repository ="https://charts.jetstack.io"
  chart = "cert-manager"
  version = var.cert_manager_version
  cleanup_on_fail = true
  namespace = "cert-manager"
  # force_update = true

  set {
    name  = "installCRDs"
    value = true
  }

  depends_on = [kubernetes_namespace.cert_manager_ns]
}