resource "azurerm_storage_account" "stg" {
  for_each = var.stgs

  name                                 = each.value.name
  resource_group_name                  = var.rgname[each.value.rg_key] #.name
  location                             = var.rglocation[each.value.rg_key] #.location
  account_kind                         = lookup(each.value, "account_kind", null)
  account_tier                         = lookup(each.value, "account_tier", null)
  account_replication_type             = lookup(each.value, "account_replication_type", null)
  provisioned_billing_model_version    = lookup(each.value, "provisioned_billing_model_version", null)
  cross_tenant_replication_enabled     = lookup(each.value, "cross_tenant_replication_enabled", null)
  access_tier                          = lookup(each.value, "access_tier", null)
  edge_zone                            = lookup(each.value, "edge_zone", null)
  https_traffic_only_enabled           = lookup(each.value, "https_traffic_only_enabled", null)
  min_tls_version                      = lookup(each.value, "min_tls_version", null)
  allow_nested_items_to_be_public      = lookup(each.value, "allow_nested_items_to_be_public", null)
  shared_access_key_enabled            = lookup(each.value, "shared_access_key_enabled", null)
  public_network_access_enabled        = lookup(each.value, "public_network_access_enabled", null)
  default_to_oauth_authentication      = lookup(each.value, "default_to_oauth_authentication", null)
  is_hns_enabled                       = lookup(each.value, "is_hns_enabled", null)
  nfsv3_enabled                        = lookup(each.value, "nfsv3_enabled", null)

  
  # dynamic "custom_domain" {
  #   for_each = lookup(each.value, "custom_domain", [])
  #   content {
  #     name               = custom_domain.value.name
  #     use_subdomain_name = custom_domain.value.use_subdomain_name
  #   }
  # }

  # dynamic "customer_managed_key" {
  #   for_each = try(each.value, "customer_managed_key", {})
  #   content {
      
  #     key_vault_key_id = customer_managed_key.value.key_vault_key_id
      
  #     user_assigned_identity_id = lookup(customer_managed_key.value, "user_assigned_identity_id", null)
  #     managed_hsm_key_id =lookup(customer_managed_key.value, "managed_hsm_key_id", null)
  #   }
  # }

  dynamic "identity" {
    for_each = lookup(each.value, "identity", {})
    content {
      type = identity.value.type
      # if user_assigned_identities are needed:
     identity_ids = lookup(identity.value, "identity_ids", [])
    }
  }

  # dynamic "blob_properties" {
  #   for_each = lookup(each.value, "blob_properties", [])
  #   content {
  #     delete_retention_days    = lookup(blob_properties.value, "delete_retention_days", null)
  #     is_versioning_enabled    = lookup(blob_properties.value, "is_versioning_enabled", null)
  #   }
  # }

  # dynamic "queue_properties" {
  #   for_each = lookup(each.value, "queue_properties", [])
  #   content {
  #     logging_enabled = lookup(queue_properties.value, "logging_enabled", null)
  #   }
  # }

  # dynamic "static_website" {
  #   for_each = lookup(each.value, "static_website", {})
  #   content {
  #     index_document     = static_website.value.index_document
  #     error_404_document = static_website.value.error_404_document
  #   }
  # }

  # dynamic "share_properties" {
  #   for_each = lookup(each.value, "share_properties", [])
  #   content {
  #     quota = lookup(share_properties.value, "quota", null)
  #   }
  # }

  dynamic "network_rules" {
    for_each = lookup(each.value, "network_rules", {})
    content {
      default_action             = lookup(network_rules.value, "default_action", null)
      bypass                     = lookup(network_rules.value, "bypass", [])
      ip_rules                   = lookup(network_rules.value, "ip_rules", [])
      virtual_network_subnet_ids = lookup(network_rules.value, "virtual_network_subnet_ids", [])
    }
  }

  large_file_share_enabled   = lookup(each.value, "large_file_share_enabled", null)
  local_user_enabled         = lookup(each.value, "local_user_enabled", null)

  # dynamic "azure_files_authentication" {
  #   for_each = lookup(each.value, "azure_files_authentication", [])
  #   content {
  #     # adjust fields to match the provider schema (example:)
  #     directory_type = azure_files_authentication.value.directory_type
  #     saml_idp_state = lookup(azure_files_authentication.value, "saml_idp_state", null)
  #   }
  # }

  # If you intended a routing block, provide its structure in the input map.
  # dynamic "routing" {
  #   for_each = lookup(each.value, "routing", [])
  #   content {
  #     # example routing attributes (verify with provider)
  #     routing_choice = lookup(routing.value, "routing_choice", null)
  #   }
  # }

  queue_encryption_key_type        = lookup(each.value, "queue_encryption_key_type", null)
  table_encryption_key_type        = lookup(each.value, "table_encryption_key_type", null)
  infrastructure_encryption_enabled = lookup(each.value, "infrastructure_encryption_enabled", null)

  # dynamic "immutability_policy" {
  #   for_each = lookup(each.value, "immutability_policy", [])
  #   content {
  #     enabled                                         = immutability_policy.value.enabled
  #     immutability_period_since_creation_in_days     = immutability_policy.value.immutability_period_since_creation_in_days
  #   }
  # }

  # dynamic "sas_policy" {
  #   for_each = lookup(each.value, "sas_policy", [])
  #   content {
      
  #      sas_policy_name = sas_policy.value.name
  #     expiry          = sas_policy.value.expiry
  #   }
  # }

  allowed_copy_scope = lookup(each.value, "allowed_copy_scope", null)
  sftp_enabled       = lookup(each.value, "sftp_enabled", null)
  dns_endpoint_type  = lookup(each.value, "dns_endpoint_type", null)

  tags = lookup(each.value, "tags", {})
}


