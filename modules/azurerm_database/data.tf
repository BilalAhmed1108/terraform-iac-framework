data "azurerm_mssql_server" "sqlServer" {
    for_each = var.sqlserverdata
  name                = each.value.name
  resource_group_name =each.value.r_g_n
}