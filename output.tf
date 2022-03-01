output "kubeconfig" {
  value     = module.cluster.kubeconfig
  sensitive = true
}

output "rancher_url" {
  value = module.helms.rancher_url
}

output "rancher_first_pwd" {
  value     = module.helms.rancher_first_pwd
  sensitive = true
}

