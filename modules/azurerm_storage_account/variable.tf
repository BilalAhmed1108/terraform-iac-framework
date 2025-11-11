variable "stgs" {
  description = "Map of storage account definitions keyed by identifier"
  type = map(object({
    name                   = string
  account_kind                   = optional(string)
  account_tier           = string
  account_replication_type = string
   provisioned_billing_model_version =optional(string)
   cross_tenant_replication_enabled =optional(bool)
    access_tier            = optional(string)
    edge_zone = optional(string)
https_traffic_only_enabled  =optional(bool)
 min_tls_version =optional(string)
  allow_nested_items_to_be_public=optional(bool)
   shared_access_key_enabled=optional(bool)
public_network_access_enabled =optional(bool)
 default_to_oauth_authentication=optional(bool)
is_hns_enabled =optional(bool)
 nfsv3_enabled =optional(bool)

customer_managed_key = optional(map(object({
  key_vault_key_id=optional(string)
  managed_hsm_key_id =optional(string)
  user_assigned_identity_id=string
})))

identity =optional(map(object({
  type=string
  identity_ids=optional(list(string))
})),{})

static_website=optional(map(object({
    index_document= optional(string)
    error_404_document=optional(string)
})),{})

network_rules =optional(map(object({
default_action=string
# bypass=optional(string)
ip_rules=optional(list(string))
virtual_network_subnet_ids=optional(list(string))
})),{})

large_file_share_enabled=optional(bool)
local_user_enabled =optional(bool)
queue_encryption_key_type=optional(string)
table_encryption_key_type=optional(string)
infrastructure_encryption_enabled=optional(bool)
allowed_copy_scope=optional(string)
sftp_enabled=optional(bool)
dns_endpoint_type=optional(string)
tags                   =optional(map(string))
rg_key=string
    
  }))
}

variable "rgname" {}

variable "rglocation" {}
