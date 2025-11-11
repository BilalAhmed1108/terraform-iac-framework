resource "azurerm_virtual_network" "network" {
    for_each = var.network
  name                = each.value.name
  location            = var.rglocation[each.value.rg_key]
  resource_group_name = var.rgname[each.value.rg_key]
  address_space       = each.value.address_space
  bgp_community = lookup(each.value, "bgp_community", null)
  #ddos_protection_plan = lookup(each.value, "ddos_protection_plan_id", {})
dns_servers = lookup(each.value, "dns_servers", [])
edge_zone=  lookup(each.value, "edge_zone", null)
flow_timeout_in_minutes =lookup(each.value, "flow_timeout_in_minutes", null)
private_endpoint_vnet_policies = lookup(each.value, "private_endpoint_vnet_policies", "Disabled")
#private_link_service_network_policies_enabled=lookup(each.value, "private_link_service_network_policies_enabled", "Disabled")
# route_table_id=lookup(each.value, "route_table_id", null)
#service_endpoints = lookup(each.value, "service_endpoints", null)
  dynamic "subnet" {
    for_each = lookup(each.value, "subnet", {})
    content {
    name             = lookup(subnet.value, "subnet_name", "default-subnet")
    address_prefixes = lookup(subnet.value, "subnet_address_prefixes",  ["10.0.0.0/24"])
    security_group = lookup(subnet.value, "subnet_network_security_group_id", null)
    default_outbound_access_enabled = lookup(subnet.value, "default_outbound_access_enabled", true)
    private_endpoint_network_policies = lookup(subnet.value, "private_endpoint_network_policies", "Enabled")
    private_link_service_network_policies_enabled=lookup(subnet.value, "private_link_service_network_policies_enabled", true   )
    route_table_id = lookup(subnet.value, "route_table_id", null    )
    service_endpoints = lookup(subnet.value, "service_endpoints", []     )
    
  }
  }

  dynamic "encryption" {
    for_each = lookup(each.value, "encryption", {})
    content {
      enforcement = lookup(each.value, "encryption_enforcement", "AllowUnencrypted")
    }
  }
  
#  dynamic "ddos_protection_plan" {
#     for_each = lookup(each.value, "ddos_protection_plan_id", {})
#     content {
#       id = lookup(each.value, "ddos_protection_plan_id", null)
#       enable = lookup(each.value, "ddos_protection_enable", "Enable")
#     }
#  }
  
# dynamic "delegation"{
#     for_each = lookup(each.value, "delegation", {})
#     content {
#       name = lookup(delegation.value, "name", null)
#       service_delegation {
#         name = lookup(each.value, "service_name", null)
#         actions = lookup(each.value, "actions", [])
#       }
#     }
# }



tags = lookup(each.value, "tags", {})
}
