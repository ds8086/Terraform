# providers
provider "bigip" {
  address  = var.bigip_hostname
  username = var.bigip_username
  password = var.bigip_password
}

# nodes
resource "bigip_ltm_node" "nodes_tf" {
  for_each = var.app_nodes
  name     = "/${var.app_partition}/${each.key}"
  address  = each.value
  monitor  = "default"
}