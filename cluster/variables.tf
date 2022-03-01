variable "cluster_name" {
  type    = string
  default = "default_cluster"
}
variable "token" {
  type = string
}
variable "region" {
  type = string
}
variable "node_pool_name" {
  type = string
}
variable "node_pool_size" {
  type = string
}
variable "node_count_min" {
  type    = number
  default = 2
}
variable "node_count_max" {
  type    = number
  default = 2
}
