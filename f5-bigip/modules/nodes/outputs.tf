# output
output "output" {
  value = [for name in bigip_ltm_node.nodes_tf : name]
}