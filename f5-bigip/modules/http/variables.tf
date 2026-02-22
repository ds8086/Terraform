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
variable "app_name" {
  type        = string
  description = "Naming convention for virtual server, pool, and monitor"
}
variable "app_ip" {
  type        = string
  description = "IP address for app (virtual server)"
}
variable "app_port" {
  type        = list(number)
  description = "Port number for app"
}
variable "app_nodes" {
  description = "Output from 'nodes' module (do not specify)"
}
variable "app_partition" {
  type        = string
  description = "F5 partition where pools will be created (needs to match 'node_partition' in 'nodes' module)"
}
variable "app_rules" {
  default = null
  description = "List of app iRules (files must exist as .tcl)"
}