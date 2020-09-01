resource kubernetes_namespace monitoring_ns{
  metadata{
    name = var.monitoring_namespace
  }
}
resource helm_release prometheus {
  name = "${var.monitoring_name}-prometheus"
  repository = "https://kubernetes-charts.storage.googleapis.com"
  chart = "prometheus"
  version = var.prometheus_chart_version
  cleanup_on_fail = true
  namespace = var.monitoring_namespace

  depends_on = [kubernetes_namespace.monitoring_ns]

  set {
    name = "alertmanager.enabled"
    value = "false"
  }
  set {
    name = "nodeExporter.enabled"
    value = "false"
  }
  set {
    name = "pushgateway.enabled"
    value = "false"
  }
}

resource helm_release grafana {
  name = "${var.monitoring_name}-grafana"
  repository = "https://kubernetes-charts.storage.googleapis.com"
  chart = "grafana"
  version = var.grafana_chart_version
  cleanup_on_fail = true
  namespace = var.monitoring_namespace

  depends_on = [kubernetes_namespace.monitoring_ns]

  set {
    name = "sidecar.dashboards.enabled"
    value = "true"
  }
  //will use default label: grafana_dashboard = 1

  set {
    name = "sidecar.datasources.enabled"
    value = "true"
  }

  # set {
  #   name = ""
  #   value = ""
  # }
}
#
# Obtain monitoring address
#
# data "kubernetes_service" "monitoring_controller" {
#   metadata {
#     name = "${var.monitoring_name}-monitoring-nginx-controller" #################################################
#     namespace = var.monitoring_namespace
#   }
#   depends_on = [helm_release.monitoring]
# }