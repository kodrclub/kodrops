resource kubernetes_namespace ingress_ns{
  metadata{
    name = var.ingress_namespace
  }
}
resource helm_release ingress {
  name = var.ingress_name
  repository ="https://kubernetes.github.io/ingress-nginx"
  chart = "ingress-nginx"
  version = var.ingress_version
  # force_update = true
  cleanup_on_fail = true
  namespace = var.ingress_namespace

  depends_on = [kubernetes_namespace.ingress_ns]
}

#
# Obtain ingress address
#
data "kubernetes_service" "ingress_controller" {
  metadata {
    name = "${var.ingress_name}-ingress-nginx-controller" #################################################
    namespace = var.ingress_namespace
  }
  depends_on = [helm_release.ingress]
}