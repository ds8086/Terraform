# F5 appliance variables
variable "bigip_hostname" {
  type        = string
  default     = "lv1-f5-sb-int.c1b.corp"
  description = "Hostname of the F5"
}
variable "bigip_username" {
  type        = string
  default     = "svc_terraform_sb"
  description = "Username for connecting to F5"
}
variable "bigip_password" {
  type        = string
  sensitive   = true
  description = "Password for connecting to F5"
}