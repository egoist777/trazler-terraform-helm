resource "helm_release" "trazler" {
  name       = "${var.release_name}-${local.env}"
  chart      = "../trazler-helm-chart"

  values = [
    templatefile("../trazler-helm-chart/values.yaml", { tagName = "${var.docker_tag}" })
  ]
  }
