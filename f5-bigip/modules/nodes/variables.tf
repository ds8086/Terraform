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

# Node variables
variable "app_nodes" {
  type        = map(any)
  description = "Map of node name (key) and IP address (value)"
}
variable "app_partition" {
  type        = string
  description = "Partition where nodes will be created"
}