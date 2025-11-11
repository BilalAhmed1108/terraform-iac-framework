variable "kv" {
  type = map(object({
    name                        = string
    location                    = string
    resource_group_name         = string
    enabled_for_disk_encryption = optional(bool)   #true
    soft_delete_retention_days  = optional(number)   #
    purge_protection_enabled    = optional(bool)   # false
    enabled_for_deployment     = optional(bool)   # true
    enabled_for_template_deployment = optional(bool)   # true
    public_network_access_enabled = optional(bool)  # true
    tags                        = optional(map(string))   # {}
    sku_name                    = string    # standard
    rbac_authorization_enabled  = bool   # true
    network_acls = optional(object({
      bypass                     = string   # None
      default_action             = string   # Deny
      ip_rules                   = optional(list(string))   # []
      virtual_network_subnet_ids = optional(list(string))   # []
    }))
    role_definition_name           = string
      }))
}



variable "kvsec" {
  type = map(object({
    name         = string
    value        = optional(string)
    value_wo     = optional(string)
    value_wo_version = optional(string)
    content_type = optional(string)
    tags         = optional(map(string))
    not_before_date = optional(string)
    expiration_date = optional(string)
    kvid                           = string

  }))
}
