resource "azurerm_mssql_database" "sqldatabase" {
    for_each = var.database
  name         = each.value.name
  server_id    = data.azurerm_mssql_server.sqlServer[each.key].id
  auto_pause_delay_in_minutes = each.value.auto_pause_delay_in_minutes
  collation    = each.value.collation
  license_type = each.value.license_type
  max_size_gb  = each.value.max_size_gb
  sku_name     = each.value.sku_name
  enclave_type=   each.value.enclave_type
create_mode= each.value.create_mode
creation_source_database_id = each.value.creation_source_database_id
elastic_pool_id = each.value.elastic_pool_id  
geo_backup_enabled= each.value.geo_backup_enabled
maintenance_configuration_name = each.value.maintenance_configuration_name
ledger_enabled = each.value.ledger_enabled  
 min_capacity = each.value.min_capacity
 restore_point_in_time =each.value.restore_point_in_time
 recover_database_id = each.value.recover_database_id
 recovery_point_id =each.value.recovery_point_id
 restore_dropped_database_id=   each.value.restore_dropped_database_id
 restore_long_term_retention_backup_id = each.value.restore_long_term_retention_backup_id
 read_replica_count = each.value.read_replica_count
 read_scale= each.value.read_scale
sample_name = each.value.sample_name
storage_account_type = each.value.storage_account_type
 transparent_data_encryption_enabled = each.value.transparent_data_encryption_enabled
 transparent_data_encryption_key_vault_key_id= each.value.transparent_data_encryption_key_vault_key_id
 transparent_data_encryption_key_automatic_rotation_enabled=each.value.transparent_data_encryption_key_automatic_rotation_enabled
 zone_redundant = each.value.zone_redundant
 secondary_type =each.value.secondary_type

  tags = each.value.tags
}
# dynamic "import" {
# for_each= lookup(each.value, "import", {})
# content {

# }  
# }


# long_term_retention_policy {
#     for_each = var.database
#   database_id = azurerm_mssql_database.example[each.key].id
#   weekly_retention = lookup(each.value, "long_term_retention_policy", {})["weekly_retention"]
#   monthly_retention = lookup(each.value, "long_term_retention_policy", {})["monthly_retention"]
#   yearly_retention = lookup(each.value, "long_term_retention_policy", {})["yearly_retention"]
#   week_of_year = lookup(each.value, "long_term_retention_policy", {})["week_of_year"]
# }

# dynamic "short_term_retention_policy" {
#     for_each = lookup(each.value, "short_term_retention_policy", {})
# content{

# }
# }

# dynamic "threat_detection_policy" {
#     for_each = lookup (each.value, "threat_detection_policy", {})
#     content {

#     }

# }

# dynamic "identity"{
#     for_each = lookup (each.value, "identity", {})
#     content {

#     }

# }

