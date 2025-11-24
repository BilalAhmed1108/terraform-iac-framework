resource "azurerm_container_registry" "akr" {
  for_each = var.akr
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  sku                 = each.value.sku
    admin_enabled = lookup(each.value, "admin_enabled", false)
     tags=  each.value.tags
     public_network_access_enabled = lookup(each.value, "public_network_access_enabled", true)
     quarantine_policy_enabled= lookup(each.value, "quarantine_policy_enabled", null)  
  retention_policy_in_days= lookup(each.value, "retention_policy_in_days", null)
  trust_policy_enabled= lookup(each.value, "trust_policy_enabled", false)   
   zone_redundancy_enabled= lookup(each.value, "zone_redundancy_enabled", false)
   export_policy_enabled = lookup(each.value, "export_policy_enabled", true)
  anonymous_pull_enabled = lookup(each.value, "anonymous_pull_enabled", null)
  data_endpoint_enabled = lookup(each.value, "data_endpoint_enabled", null)
  network_rule_bypass_option= lookup(each.value, "network_rule_bypass_option", "AzureServices")
  
  dynamic "georeplications" {
    for_each = each.value.georeplications != null ? [each.value.georeplications] : []
    content {
      location = lookup(georeplications.value, "location", null)  #required
      regional_endpoint_enabled = lookup(georeplications.value, "regional_endpoint_enabled", null)  
      zone_redundancy_enabled = lookup(georeplications.value, "zone_redundancy_enabled", false)  
    }
  }


  dynamic "network_rule_set" {
    for_each = each.value.network_rule_set != null ? [each.value.network_rule_set] : []
    content {
      default_action = lookup(network_rule_set.value, "default_action", "Allow") 

    }
  }


  dynamic "identity" {
    for_each = each.value.identity != null ? [each.value.identity] : []
    content {
      type= lookup(identity.value, "type", "SystemAssigned, UserAssigned") # required
      identity_ids = lookup(identity.value, "identity_ids", null)   
    }
  }


dynamic "encryption" {
    for_each = each.value.encryption != null ? [each.value.encryption] : []
    content {
      key_vault_key_id = lookup(encryption.value, "key_vault_key_id", null) #required
      identity_client_id = lookup(encryption.value, "identity_client_id", null)
    }
  }




}

