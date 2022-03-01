output "kubeconfig" {
  value = digitalocean_kubernetes_cluster.cluster.kube_config[0].raw_config
}
output "cluster_endpoint" {
  value = digitalocean_kubernetes_cluster.cluster.endpoint
}
output "cluster_token" {
  value = digitalocean_kubernetes_cluster.cluster.kube_config[0].token
}
output "cluster_ca_certificate" {
  value = digitalocean_kubernetes_cluster.cluster.kube_config[0].cluster_ca_certificate
}
