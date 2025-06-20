variable "app_partition" {}
variable "app_ip" {}
variable "app_port" {}
variable "app_nodes" {}
variable "app_protocol" {}
variable "app_gtm" {
    type = bool
}
variable "app_fqdn" {}
variable "app_cert" {
    default = ""
}
variable "app_key" {
    default = ""
}
variable "gtm_server" {}