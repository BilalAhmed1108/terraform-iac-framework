variable "database" {
  type = map(object({
    name= optional(string)
    auto_pause_delay_in_minutes = optional(string)
    collation    = optional(string)
  license_type = optional(string)
  max_size_gb  = optional(string)
  sku_name     = optional(string)
  enclave_type=  optional(string)
create_mode= optional(string)  
creation_source_database_id = optional(string)   
elastic_pool_id = optional(string)  
geo_backup_enabled= optional(string)
maintenance_configuration_name = optional(string)
ledger_enabled = optional(bool)  
 min_capacity = optional(string)
 restore_point_in_time = optional(string)
 recover_database_id = optional(string)
 recovery_point_id = optional(string)
 restore_dropped_database_id=   optional(string)
 restore_long_term_retention_backup_id = optional(string)
 read_replica_count = optional(string)
 read_scale= optional(string)
sample_name = optional(string)
storage_account_type = optional(string)
 transparent_data_encryption_enabled = optional(bool)
 transparent_data_encryption_key_vault_key_id= optional(string)
 transparent_data_encryption_key_automatic_rotation_enabled=optional(bool)
 zone_redundant = optional(bool)
 secondary_type =optional(string)

  tags = optional(map(string))
  }))
}


variable "sqlserverdata" {
  type = map(object({
    name = string
    r_g_n=string
  }))
}