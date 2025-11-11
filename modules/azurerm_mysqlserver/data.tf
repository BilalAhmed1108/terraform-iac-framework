data "azurerm_key_vault" "keyvault" {
    for_each = var.keyvaultid
  name                = each.value.name
  resource_group_name = each.value.r_g_n
}


data "azurerm_key_vault_secret" "keyvaultsecret" {
  for_each = var.kvsec
  name         = each.value.name
  key_vault_id = data.azurerm_key_vault.keyvault[each.value.kvid].id
  
}