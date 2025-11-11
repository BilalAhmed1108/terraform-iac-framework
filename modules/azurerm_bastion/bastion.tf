resource "azurerm_bastion_host" "bastion" {
    for_each = var.bastion
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
copy_paste_enabled=lookup(each.value,"copy_paste_enabled",true)
file_copy_enabled=lookup(each.value,"file_copy_enabled",false)   
sku=lookup(each.value,"sku","Basic")
ip_connect_enabled=lookup(each.value,"ip_connect_enabled",false)
kerberos_enabled=lookup(each.value,"kerberos_enabled",false)
scale_units =lookup(each.value,"scale_units",2)
shareable_link_enabled=lookup(  each.value,"shareable_link_enabled",false)
session_recording_enabled =lookup(each.value,"session_recording_enabled",false) 
virtual_network_id =lookup( each.value,"virtual_network_id",null)
 zones = lookup(each.value, "zones", null)  
 
 dynamic "ip_configuration" {
    for_each = each.value.ip_configuration
    content {
   name=lookup(each.value,"ip_configuration_name","configuration")
    subnet_id            = data.azurerm_subnet.subnet[each.value.subnetid].id
    public_ip_address_id = data.azurerm_public_ip.pip[each.value.pipid].id
  }
 }
}

