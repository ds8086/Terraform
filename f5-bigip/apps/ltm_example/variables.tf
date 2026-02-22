variable "bigip_hostname" {
  type        = string
  description = "Hostname of F5"
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