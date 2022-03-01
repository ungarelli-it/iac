resource "digitalocean_kubernetes_cluster" "cluster" {
  name    = var.cluster_name
  region  = var.region
  version = "1.21.9-do.0"

  tags = ["terraform"]

  node_pool {
    name       = var.node_pool_name
    size       = var.node_pool_size
    auto_scale = true
    node_count = var.node_count_min
    min_nodes  = var.node_count_min
    max_nodes  = var.node_count_max
    tags       = ["terraform"]
  }
}

resource "local_file" "kubeconfig" {
  depends_on = [digitalocean_kubernetes_cluster.cluster]
  content    = digitalocean_kubernetes_cluster.cluster.kube_config[0].raw_config
  filename   = "${path.root}/kubeconfig"
}
