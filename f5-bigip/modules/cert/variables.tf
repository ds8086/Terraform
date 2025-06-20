# F5 appliance variables
variable "bigip_hostname" {
  type        = string
  description = "Hostname of the F5"
}
variable "bigip_username" {
  type        = string
  description = "Username for connecting to F5"
}
variable "bigip_password" {
  type        = string
  sensitive   = true
  description = "Password for connecting to F5"
}

# App variables
variable "app_partition" {
  type        = string
  description = "F5 where partition cert, key, and ssl profiles are created"
}
variable "app_cert" {
  type        = string
  description = "FQDN for app certificate and key (files must exist as .crt and .key)"
}