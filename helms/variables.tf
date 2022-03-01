variable "cluster_name" {
  type = string
}

variable "cluster_endpoint" {
  type = string
}
variable "cluster_token" {
  type = string
}
variable "cluster_ca_certificate" {
  type = string
}
variable "cluster_issuer_mail" {
  type = string
}

variable "rancher_version" {
  type    = string
  default = "v2.6.3"
}

variable "global_domain" {
  type = string
}
