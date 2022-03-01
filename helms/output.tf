output "rancher_url" {
  value = "https://rancher.${var.global_domain}"
}

output "rancher_first_pwd" {
  value = random_password.rancher_first_pwd.result
}

