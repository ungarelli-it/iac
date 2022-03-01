provider "kubernetes" {
  host                   = var.cluster_endpoint
  token                  = var.cluster_token
  cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
}

provider "kubectl" {
  load_config_file       = false
  host                   = var.cluster_endpoint
  token                  = var.cluster_token
  cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
  apply_retry_count      = 5
}

provider "helm" {
  kubernetes {
    host                   = var.cluster_endpoint
    token                  = var.cluster_token
    cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
  }
}
