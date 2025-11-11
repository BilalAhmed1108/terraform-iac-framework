# output "networkname" {
#   value = { for k, network in azurerm_virtual_network.network : k => network.name}
# }

# output "subnetname" {
#   value = { 
#     for k, v  in azurerm_virtual_network.network : 
#     k => [for s in v.subnet : s.name]
#     }
# }

# output "subnetid" {
#    value = { 
#     for k, v  in azurerm_virtual_network.network : 
#     k => [for s in v.subnet : s.id]
#     }
#     }
