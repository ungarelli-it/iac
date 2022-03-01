terraform {
  cloud {
    organization = "ungarelli-corp"

    workspaces {
      name = "iac"
    }
  }
}

module "cluster" {
  source         = "./cluster"
  cluster_name   = var.CLUSTER_NAME
  region         = "ams3"
  token          = var.TOKEN
  node_pool_name = "${var.CLUSTER_NAME}-node-pool"
  node_pool_size = var.NODE_POOL_SIZE
  node_count_min = 2
  node_count_max = 2
}

module "helms" {
  source                 = "./helms"
  cluster_name           = var.CLUSTER_NAME
  cluster_endpoint       = module.cluster.cluster_endpoint
  cluster_token          = module.cluster.cluster_token
  cluster_ca_certificate = module.cluster.cluster_ca_certificate
  global_domain          = var.DOMAIN
  cluster_issuer_mail    = var.ADMIN_MAIL
}

module "manifests" {
  source                 = "./manifests"
  cluster_endpoint       = module.cluster.cluster_endpoint
  cluster_token          = module.cluster.cluster_token
  cluster_ca_certificate = module.cluster.cluster_ca_certificate
}
