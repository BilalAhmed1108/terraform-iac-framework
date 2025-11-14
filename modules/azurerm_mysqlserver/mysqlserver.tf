resource "azurerm_mssql_server" "sqlserver" {
    for_each = var.sqlserver
  name                         = each.value.name
  resource_group_name          = each.value.resource_group_name 
  location                     = each.value.location
  version                      = each.value.version
  administrator_login          = data.azurerm_key_vault_secret.keyvaultsecret["${each.value.name}username"].value 
  administrator_login_password = data.azurerm_key_vault_secret.keyvaultsecret["${each.value.name}password"].value
  minimum_tls_version          = lookup(each.value, "minimum_tls_version", "1.2")
  administrator_login_password_wo = lookup(each.value, "administrator_login_password_wo", null)
  administrator_login_password_wo_version=lookup(each.value, "administrator_login_password_wo_version", null)
  connection_policy = lookup(each.value, "connection_policy", "Default")
   express_vulnerability_assessment_enabled=lookup(each.value, "express_vulnerability_assessment_enabled", false)
transparent_data_encryption_key_vault_key_id=lookup(each.value, "transparent_data_encryption_key_vault_key_id", null)   
public_network_access_enabled = lookup(each.value, "public_network_access_enabled", true)   
outbound_network_restriction_enabled = lookup(each.value, "outbound_traffic_enabled", false)
primary_user_assigned_identity_id = lookup(each.value, "primary_user_assigned_identity_id", null)


  dynamic "azuread_administrator" {
    for_each = each.value.azuread_administrator != null ? [each.value.azuread_administrator] : []
    content {
    login_username =lookup(azuread_administrator.value, "login_username", null)
    object_id      = lookup(azuread_administrator.value, "object_id", null)
    tenant_id = lookup(azuread_administrator.value, "tenant_id", null)
    azuread_authentication_only=lookup(azuread_administrator.value, "azuread_authentication_only", null)
  }
  }
  dynamic "identity" {
    for_each = each.value.identity != null ? [each.value.identity] : []
    content {
    type = lookup(identity.value, "type", "SystemAssigned, UserAssigned")
    identity_ids=lookup(identity.value, "identity_ids", [])
  }
  }

  tags = lookup(each.value, "tags", {})
}