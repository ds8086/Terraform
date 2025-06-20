# outputs
output "output" {
  value       = bigip_ltm_irule.rule_tf.*.name
  description = "Name of iRules created"
}