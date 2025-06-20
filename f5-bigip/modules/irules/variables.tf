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
  description = "F5 where iRules are created"
}
variable "app_rules" {
  type        = list(string)
  description = "List of app iRules (files must exist as .tcl)"
}