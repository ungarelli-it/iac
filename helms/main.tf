resource "random_password" "rancher_first_pwd" {
  length  = 16
  special = false
}

resource "helm_release" "ingress-nginx" {
  name = "ingress-nginx"

  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  namespace        = "ingress-nginx"
  wait             = true
  timeout          = 600
  create_namespace = true

  lifecycle {
    ignore_changes = [metadata]
  }
}

resource "helm_release" "cert-manager" {
  name = "cert-manager"

  repository       = "https://charts.jetstack.io"
  chart            = "cert-manager"
  namespace        = "cert-manager"
  wait             = true
  create_namespace = true

  set {
    name  = "createCustomResource"
    value = "true"
  }
  set {
    name  = "installCRDs"
    value = "true"
  }
}

resource "helm_release" "rancher_server" {
  depends_on = [helm_release.cert-manager]

  repository       = "https://releases.rancher.com/server-charts/latest"
  name             = "rancher"
  chart            = "rancher"
  version          = var.rancher_version
  namespace        = "cattle-system"
  create_namespace = true
  wait             = true

  set {
    name  = "hostname"
    value = "rancher.${var.global_domain}"
  }

  set {
    name  = "replicas"
    value = "1"
  }

  set {
    name  = "bootstrapPassword"
    value = random_password.rancher_first_pwd.result
  }

  lifecycle {
    ignore_changes = [metadata]
  }
}

resource "kubectl_manifest" "cluster-issuer-staging" {
  yaml_body = <<YAML
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
 name: letsencrypt-staging
spec:
 acme:
   server: https://acme-staging-v02.api.letsencrypt.org/directory
   email: ${var.cluster_issuer_mail}
   privateKeySecretRef:
     name: letsencrypt-staging
   solvers:
   - http01:
       ingress:
         class: nginx
YAML
}

resource "kubectl_manifest" "cluster-issuer-prod" {
  yaml_body = <<YAML
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
 name: letsencrypt-prod
spec:
 acme:
   server: https://acme-v02.api.letsencrypt.org/directory
   email: ${var.cluster_issuer_mail}
   privateKeySecretRef:
     name: letsencrypt-prod
   solvers:
   - http01:
       ingress:
         class: nginx
YAML
}
