data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv" {
    for_each = var.kv
  name                        = each.value.name
  location                    = each.value.location
  resource_group_name         = each.value.resource_group_name
  enabled_for_disk_encryption = each.value.enabled_for_disk_encryption
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = each.value.soft_delete_retention_days
  purge_protection_enabled    = each.value.purge_protection_enabled
enabled_for_deployment = lookup(each.value, "enabled_for_deployment", true)
enabled_for_template_deployment = lookup(each.value, "enabled_for_template_deployment", true)   
public_network_access_enabled =lookup(each.value, "public_network_access_enabled", true)
 tags =lookup(each.value, "tags", {})

 dynamic "network_acls" {
   for_each = lookup(each.value, "network_acls", null) != null ? [each.value.network_acls] : []
   content {
     bypass = lookup(network_acls.value, "bypass", null)
    default_action = lookup(network_acls.value, "default_action", "Deny")
    ip_rules = lookup(network_acls.value, "ip_rules", null)
    virtual_network_subnet_ids = lookup(network_acls.value, "virtual_network_subnet_ids", null)
   }
 }

  sku_name = each.value.sku_name
  rbac_authorization_enabled = each.value.rbac_authorization_enabled
}



#resource "azurerm_role_assignment" "admin" {
 # depends_on = [ azurerm_key_vault.kv ]
  #for_each = var.kv
  #scope                = azurerm_key_vault.kv[each.key].id
  #role_definition_name = each.value.role_definition_name
  #principal_id         = data.azurerm_client_config.current.object_id
#}



resource "azurerm_key_vault_secret" "kvsec" {
  depends_on = [ azurerm_key_vault.kv, azurerm_role_assignment.admin ]
    for_each = var.kvsec
  name         = each.value.name
  value        = each.value.value
  key_vault_id = azurerm_key_vault.kv[each.value.kvid].id
  value_wo =lookup(each.value, "value_wo", null)
  value_wo_version = lookup(each.value, "value_wo_version", null)
  content_type=lookup(each.value, "content_type", null)
  tags = lookup(each.value, "tags", {})
  not_before_date = lookup(each.value, "not_before_date", null)
  expiration_date = lookup(each.value, "expiration_date", null)
}
