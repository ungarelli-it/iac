resource "kubernetes_namespace" "hlg" {
  metadata {
    name = "dsv"
  }
  lifecycle {
    ignore_changes = [metadata]
  }
}

resource "kubernetes_namespace" "prd" {
  metadata {
    name = "prd"
  }
  lifecycle {
    ignore_changes = [metadata]
  }
}
