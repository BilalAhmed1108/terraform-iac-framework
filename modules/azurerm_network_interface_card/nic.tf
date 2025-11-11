resource "azurerm_network_interface" "nic" {
  for_each = var.nic

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  auxiliary_mode      = lookup(each.value, "auxiliary_mode", "None")
  auxiliary_sku       = lookup(each.value, "auxiliary_sku", "None")
  tags                = lookup(each.value, "tags", {})
  dns_servers         = lookup(each.value, "dns_servers", null)
  edge_zone           = lookup(each.value, "edge_zone", null)
  ip_forwarding_enabled = lookup(each.value, "ip_forwarding_enabled", false)
  accelerated_networking_enabled = lookup(each.value, "accelerated_networking_enabled", false)
  internal_dns_name_label = lookup(each.value, "internal_dns_name_label", null)

  dynamic "ip_configuration" {
    for_each = lookup(each.value, "ip_configurations", {})

    content {
      name = lookup(ip_configuration.value, "name", "internal")

      gateway_load_balancer_frontend_ip_configuration_id = lookup(ip_configuration.value,"gateway_load_balancer_frontend_ip_configuration_id",null)

      public_ip_address_id = data.azurerm_public_ip.pip[each.value.pipid].id
      subnet_id            = data.azurerm_subnet.subnet[each.value.subnetid].id

      private_ip_address_version     = lookup(ip_configuration.value, "private_ip_address_version", "IPv4")
      private_ip_address_allocation  = lookup(ip_configuration.value, "private_ip_address_allocation", "Dynamic")
      primary                        = lookup(ip_configuration.value, "primary", true)
    }
  }
}







