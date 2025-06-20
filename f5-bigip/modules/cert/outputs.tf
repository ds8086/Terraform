# outputs
output "clientssl" {
  value       = bigip_ltm_profile_client_ssl.clientssl_tf.name
  description = "The name of client SSL profile created to use the cert & key"
}
output "serverssl" {
  value       = bigip_ltm_profile_server_ssl.serverssl_tf.name
  description = "The name of server SSL profile created to use the cert & key"
}