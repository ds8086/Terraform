resource "bigip_as3" "app_services" {
  as3_json    = local.as3_json
  tenant_name = var.app_partition
}

resource "local_file" "as3" {
  content  = local.as3_json
  filename = "${path.module}/as3.json"
}

locals {
  file = (var.app_gtm == true) ? "${path.module}/json/${var.app_protocol}_gtm.json" : "${path.module}/json/${var.app_protocol}.json"

  as3_json = templatefile(local.file, {
    PARTITION = var.app_partition
    PROTOCOL  = var.app_protocol
    VIP       = var.app_ip
    PORT      = var.app_port
    FQDN      = var.app_fqdn
    NODES     = jsonencode(var.app_nodes)
    CERT      = jsonencode(var.app_cert)
    KEY       = jsonencode(var.app_key)
    GTMSERVER = var.gtm_server
  })
}