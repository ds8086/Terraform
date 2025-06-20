# providers
provider "bigip" {
  address  = var.bigip_hostname
  username = var.bigip_username
  password = var.bigip_password
}

# virtual server
resource "bigip_ltm_virtual_server" "vs_tf" {
  count                      = length(var.app_port)
  name                       = "/${var.app_partition}/vs_${var.app_name}_${var.app_port[count.index]}_udp"
  destination                = var.app_ip
  port                       = var.app_port[count.index]
  ip_protocol                = "udp"
  pool                       = bigip_ltm_pool.pool_tf[count.index].name
  profiles                   = ["/Common/udp"] # cannot create a udp profile via terraform ¯\_(ツ)_/¯
  irules                     = (var.app_rules != null) ? var.app_rules : null
  source_address_translation = "automap"
  
  lifecycle {
    ignore_changes = [
      profiles
    ]
  }

  depends_on = [
    bigip_ltm_pool.pool_tf
  ]
}

# pool
resource "bigip_ltm_pool" "pool_tf" {
  count                  = length(var.app_port)
  name                   = "/${var.app_partition}/pool_${var.app_name}_${var.app_port[count.index]}_udp"
  load_balancing_mode    = "round-robin"
  minimum_active_members = 1
  monitors               = [bigip_ltm_monitor.monitor_tf[count.index].name]

  depends_on = [
    bigip_ltm_monitor.monitor_tf
  ]
}

# monitors
resource "bigip_ltm_monitor" "monitor_tf" {
  count  = length(var.app_port)
  name   = "/${var.app_partition}/monitor_${var.app_name}_${var.app_port[count.index]}_udp"
  parent = "/Common/udp"
}

# pool members
resource "bigip_ltm_pool_attachment" "pool_tf_members" {
  for_each = {
    for pm in setproduct(bigip_ltm_pool.pool_tf.*.name, var.app_nodes.*.name) : "${pm[0]}-${pm[1]}" => {
      pool = pm[0]
      node = pm[1]
      port = replace(pm[0], "/${var.app_partition}/pool_${var.app_name}_", "")
    }
  }

  pool = each.value.pool
  node = "${each.value.node}:${replace(each.value.port, "_udp", "")}"
  
  depends_on = [
    bigip_ltm_pool.pool_tf
  ]
}