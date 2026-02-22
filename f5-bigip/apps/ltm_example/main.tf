# LTM nodes (produces output)
/*
  app_nodes = module.nodes.output
*/
module "nodes" {
  source = "../../modules/nodes"
  
  bigip_hostname = var.bigip_hostname
  bigip_username = var.bigip_username
  bigip_password = var.bigip_password

  app_partition = "Common"
  app_nodes     = {
    "webserver01" = "192.168.100.1"
    "webserver02" = "192.168.100.2"
  }
}

# Certificate, key, and corresponding client & server SSL profiles (produces output)
/*
  app_clientssl = module.cert.clientssl
  app_serverssl = module.cert.serverssl
*/
module "cert" {
  source = "../../modules/cert"

  bigip_hostname = var.bigip_hostname
  bigip_username = var.bigip_username
  bigip_password = var.bigip_password
  
  app_partition = "Common"
  app_cert      = "example.lab.local" # The files 'example.lab.local.crt' and 'example.lab.local.key' must exist in app directory
}

# iRules (produces output)
/*
  app_rules = module.irules.output
*/
module "irules" {
  source = "../../modules/irules"

  bigip_hostname = var.bigip_hostname
  bigip_username = var.bigip_username
  bigip_password = var.bigip_password

  app_partition = "Common"
  # The files 'lb_logging.tcl' and 'x-forwarded-for.tcl' must exist in the app directory
  app_rules     = [
    "lb_logging",
    "x-forwarded-for"
  ]
}

# tcp
module "tcp" {
  source = "../../modules/tcp"

  bigip_hostname = var.bigip_hostname
  bigip_username = var.bigip_username
  bigip_password = var.bigip_password

  app_partition = "Common"
  app_name      = "example"
  app_ip        = "192.168.200.1"
  app_port      = [42069, 42070]
  app_nodes     = module.nodes.output
}

# tcp with ssl profiles
module "tcp-ssl" {
  source = "../../modules/tcp"

  bigip_hostname = var.bigip_hostname
  bigip_username = var.bigip_username
  bigip_password = var.bigip_password

  app_partition = "Common"
  app_name      = "example"
  app_ip        = "192.168.200.1"
  app_port      = [42071]
  app_nodes     = module.nodes.output
  app_clientssl = module.cert.clientssl
  app_serverssl = module.cert.serverssl
}

# http with iRules
module "http" {
  source = "../../modules/http"

  bigip_hostname = var.bigip_hostname
  bigip_username = var.bigip_username
  bigip_password = var.bigip_password

  app_partition = "Common"
  app_name      = "example"
  app_ip        = "192.168.200.1"
  app_port      = [80]
  app_nodes     = module.nodes.output
  app_rules     = module.irules.output
}

# https with ssl profiles and iRules
module "https" {
  source = "../../modules/https"

  bigip_hostname = var.bigip_hostname
  bigip_username = var.bigip_username
  bigip_password = var.bigip_password

  app_partition = "Common"
  app_name      = "example"
  app_ip        = "192.168.200.1"
  app_port      = [443, 9443]
  app_clientssl = module.cert.clientssl
  app_serverssl = module.cert.serverssl
  app_nodes     = module.nodes.output
  app_rules     = module.irules.output
}

# udp
module "udp" {
  source = "../../modules/udp"

  bigip_hostname = var.bigip_hostname
  bigip_username = var.bigip_username
  bigip_password = var.bigip_password

  app_partition = "Common"
  app_name      = "example"
  app_ip        = "192.168.200.1"
  app_port      = [42069, 42070]
  app_nodes     = module.nodes.output
}