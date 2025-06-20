# providers
provider "bigip" {
  address  = var.bigip_hostname
  username = var.bigip_username
  password = var.bigip_password
}

# cert
resource "bigip_ssl_certificate" "cert_tf" {
  name      = var.app_cert
  content   = file("${var.app_cert}.crt")
  partition = var.app_partition
}

# key
resource "bigip_ssl_key" "key_tf" {
  name      = var.app_cert
  content   = file("${var.app_cert}.key")
  partition = var.app_partition

  depends_on = [
    bigip_ssl_certificate.cert_tf
  ]
}

# client ssl
resource "bigip_ltm_profile_client_ssl" "clientssl_tf" {
  name          = "/${var.app_partition}/clientssl_${var.app_cert}"
  defaults_from = "/Common/clientssl"
  cert          = "/${var.app_partition}/${bigip_ssl_certificate.cert_tf.name}"
  key           = "/${var.app_partition}/${bigip_ssl_key.key_tf.name}"

  depends_on = [
    bigip_ssl_certificate.cert_tf,
    bigip_ssl_key.key_tf
  ]
}

# server ssl
resource "bigip_ltm_profile_server_ssl" "serverssl_tf" {
  name          = "/${var.app_partition}/serverssl_${var.app_cert}"
  defaults_from = "/Common/serverssl"
  cert          = "/${var.app_partition}/${bigip_ssl_certificate.cert_tf.name}"
  key           = "/${var.app_partition}/${bigip_ssl_key.key_tf.name}"

  depends_on = [
    bigip_ssl_certificate.cert_tf,
    bigip_ssl_key.key_tf
  ]
}