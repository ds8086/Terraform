# providers
provider "bigip" {
  address  = var.bigip_hostname
  username = var.bigip_username
  password = var.bigip_password
}

# irules
resource "bigip_ltm_irule" "rule_tf" {
  count = length(var.app_rules)
  name  = "/${var.app_partition}/${var.app_rules[count.index]}"
  irule = file("${var.app_rules[count.index]}.tcl")
}