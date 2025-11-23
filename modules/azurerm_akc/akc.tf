resource "azurerm_kubernetes_cluster" "akc" {
  for_each            = var.akc
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  dns_prefix          = each.value.dns_prefix
  #automatic_upgrade_channel = each.value.automatic_upgrade_channel
  azure_policy_enabled                = each.value.azure_policy_enabled
  cost_analysis_enabled               = each.value.cost_analysis_enabled # sku = Standard or Premium
  custom_ca_trust_certificates_base64 = each.value.custom_ca_trust_certificates_base64
  #disk_encryption_set_id  =each.value.disk_encryption_set_id
  #edge_zone=each.value.edge_zone
  http_application_routing_enabled    = each.value.http_application_routing_enabled
  image_cleaner_enabled               = each.value.image_cleaner_enabled
  image_cleaner_interval_hours        = each.value.image_cleaner_interval_hours
  kubernetes_version                  = each.value.kubernetes_version
  local_account_disabled              = each.value.local_account_disabled
  node_os_upgrade_channel             = each.value.node_os_upgrade_channel
  node_resource_group                 = each.value.node_resource_group
  oidc_issuer_enabled                 = each.value.oidc_issuer_enabled
  open_service_mesh_enabled           = each.value.open_service_mesh_enabled
  private_cluster_enabled             = each.value.private_cluster_enabled
  private_dns_zone_id                 = each.value.private_dns_zone_id
  private_cluster_public_fqdn_enabled = each.value.private_cluster_enabled
  #ai_toolchain_operator_enabled=false
  workload_identity_enabled         = each.value.workload_identity_enabled
  role_based_access_control_enabled = each.value.role_based_access_control_enabled
  run_command_enabled               = each.value.run_command_enabled
  sku_tier                          = each.value.sku_tier
  support_plan                      = each.value.support_plan


  dynamic "default_node_pool" {
    for_each = each.value.default_node_pool != null ? [each.value.default_node_pool] : []
    content {
      name                          = lookup(each.value, "name", "default")
      node_count                    = lookup(each.value, "node_count", 1)
      vm_size                       = lookup(each.value, "vm_size", "Standard_L2aos_v4")
      capacity_reservation_group_id = lookup(each.value, "capacity_reservation_group_id", null) # optional
      auto_scaling_enabled          = lookup(each.value, "auto_scaling_enabled", false)         #optional
      host_encryption_enabled       = lookup(each.value, "host_encryption_enabled", false)      #optional
      node_public_ip_enabled        = lookup(each.value, "node_public_ip_enabled", false)       #optional
      gpu_instance                  = lookup(each.value, "gpu_instance", null)                  #optional
      host_group_id                 = lookup(each.value, "host_group_id", null)                 #optional
      fips_enabled                  = lookup(each.value, "fips_enabled", false)                 #optional
      kubelet_disk_type             = lookup(each.value, "kubelet_disk_type", "OS")             #optional
      max_pods                      = lookup(each.value, "max_pods", 40)                        #optional
      node_public_ip_prefix_id      = lookup(each.value, "node_public_ip_prefix_id", null)      #optional
      #node_labels ="" #optional
      only_critical_addons_enabled = lookup(each.value, "only_critical_addons_enabled", false) #optional
      orchestrator_version         = lookup(each.value, "orchestrator_version", "1.27.7")      #optional
      os_disk_size_gb              = lookup(each.value, "os_disk_size_gb", 30)                 #optional
      os_disk_type                 = lookup(each.value, "os_disk_type", "Managed")             # optional
      os_sku                       = lookup(each.value, "os_sku", "Ubuntu")                    #optional
      pod_subnet_id                = lookup(each.value, "pod_subnet_id", null)                 #optional
      proximity_placement_group_id = lookup(each.value, "proximity_placement_group_id", null)  #optional
      scale_down_mode              = lookup(each.value, "scale_down_mode", "Delete")           #optional
      snapshot_id                  = lookup(each.value, "snapshot_id", null)                   #optional
      temporary_name_for_rotation  = lookup(each.value, "temporary_name_for_rotation", null)   #optional
      type                         = lookup(each.value, "type", "VirtualMachineScaleSets")     #optional
      ultra_ssd_enabled            = lookup(each.value, "ultra_ssd_enabled", false)            #optional
      vnet_subnet_id               = lookup(each.value, "vnet_subnet_id", null)                #optional
      workload_runtime             = lookup(each.value, "workload_runtime", "OCIContainer")    #optional
      zones                        = lookup(each.value, "zones", [])                           #optional
    }
  }

  dynamic "identity" {
    for_each = each.value.identity != null ? [each.value.identity] : []
    content {
      type         = lookup(each.value.identity, "type", "SystemAssigned")
      identity_ids = lookup(each.value.identity, "identity_ids", []) #optional
    }
  }

  dynamic "aci_connector_linux" {
    for_each = lookup(each.value, "aci_connector_linux", {})
    content {
      subnet_name = lookup(each.value.aci_connector_linux, "subnet_name", null) # Required
    }
  }

  dynamic "api_server_access_profile" {
    for_each = each.value.api_server_access_profile != null ? [each.value.api_server_access_profile] : []
    content {
      authorized_ip_ranges                = lookup(each.value.api_server_access_profile, "authorized_ip_ranges", [])                   #optional
      subnet_id                           = lookup(each.value.api_server_access_profile, "subnet_id", null)                            #optional
      virtual_network_integration_enabled = lookup(each.value.api_server_access_profile, "virtual_network_integration_enabled", false) #optional
    }
  }

  dynamic "auto_scaler_profile" {
    for_each = each.value.auto_scaler_profile != null ? [each.value.auto_scaler_profile] : []
    content {
      balance_similar_node_groups                   = lookup(each.value.auto_scaler_profile, "balance_similar_node_groups", false)                   #optional
      daemonset_eviction_for_empty_nodes_enabled    = lookup(each.value.auto_scaler_profile, "daemonset_eviction_for_empty_nodes_enabled", false)    #optional
      daemonset_eviction_for_occupied_nodes_enabled = lookup(each.value.auto_scaler_profile, "daemonset_eviction_for_occupied_nodes_enabled", false) #optional
      expander                                      = lookup(each.value.auto_scaler_profile, "expander", "random")                                   #optional
      ignore_daemonsets_utilization_enabled         = lookup(each.value.auto_scaler_profile, "ignore_daemonsets_utilization_enabled", false)         #optional
      max_graceful_termination_sec                  = lookup(each.value.auto_scaler_profile, "max_graceful_termination_sec", 600)                    #optional
      max_node_provisioning_time                    = lookup(each.value.auto_scaler_profile, "max_node_provisioning_time", "15m")                    #optional
      max_unready_nodes                             = lookup(each.value.auto_scaler_profile, "max_unready_nodes", 3)                                 #optional
      max_unready_percentage                        = lookup(each.value.auto_scaler_profile, "max_unready_percentage", 4)                            #optional
      scale_down_delay_after_add                    = lookup(each.value.auto_scaler_profile, "scale_down_delay_after_add", "10m")                    #optional
      scale_down_delay_after_delete                 = lookup(each.value.auto_scaler_profile, "scale_down_delay_after_delete", "3m")                  #optional
      scale_down_delay_after_failure                = lookup(each.value.auto_scaler_profile, "scale_down_delay_after_failure", "3m")                 #optional
      scan_interval                                 = lookup(each.value.auto_scaler_profile, "scan_interval", "10s")                                 #optional
      scale_down_unneeded                           = lookup(each.value.auto_scaler_profile, "scale_down_unneeded", "10m")                           #optional
      scale_down_unready                            = lookup(each.value.auto_scaler_profile, "scale_down_unready", "20m")                            #optional
      scale_down_utilization_threshold              = lookup(each.value.auto_scaler_profile, "scale_down_utilization_threshold", 0.5)                #optional
      empty_bulk_delete_max                         = lookup(each.value.auto_scaler_profile, "empty_bulk_delete_max", 1)                             #optional
      skip_nodes_with_local_storage                 = lookup(each.value.auto_scaler_profile, "skip_nodes_with_local_storage", false)                 #optional
      skip_nodes_with_system_pods                   = lookup(each.value.auto_scaler_profile, "skip_nodes_with_system_pods", false)                   #optional

    }
  }

  dynamic "azure_active_directory_role_based_access_control" {
    for_each = each.value.azure_active_directory_role_based_access_control != null ? [each.value.azure_active_directory_role_based_access_control] : []
    content {
      tenant_id              = lookup(each.value.azure_active_directory_role_based_access_control, "tenant_id", null)              #optional
      admin_group_object_ids = lookup(each.value.azure_active_directory_role_based_access_control, "admin_group_object_ids", null) #optional
      azure_rbac_enabled     = lookup(each.value.azure_active_directory_role_based_access_control, "azure_rbac_enabled", null)     #optional

    }
  }

  dynamic "confidential_computing" {
    for_each = each.value.confidential_computing != null ? [each.value.confidential_computing] : []
    content {
      sgx_quote_helper_enabled = lookup(each.value.confidential_computing, "sgx_quote_helper_enabled", false)
    }
  }

  dynamic "http_proxy_config" {
    for_each = each.value.http_proxy_config != null ? [each.value.http_proxy_config] : []
    content {
      http_proxy  = lookup(each.value.http_proxy_config, "http_proxy", null)  #optional
      https_proxy = lookup(each.value.http_proxy_config, "https_proxy", null) #optional
      no_proxy    = lookup(each.value.http_proxy_config, "no_proxy", null)    #optional
      trusted_ca  = lookup(each.value.http_proxy_config, "trusted_ca", null)  #optional

    }
  }

  dynamic "ingress_application_gateway" {
    for_each = lookup(each.value, "ingress_application_gateway  ", {})
    content {
      gateway_id   = lookup(each.value.ingress_application_gateway, "gateway_id", null)   #optional
      gateway_name = lookup(each.value.ingress_application_gateway, "gateway_name", null) #optional
      subnet_cidr  = lookup(each.value.ingress_application_gateway, "subnet_cidr", null)  #optional
      subnet_id    = lookup(each.value.ingress_application_gateway, "subnet_id", null)    #optional

    }
  }

  dynamic "key_management_service" {
    for_each = lookup(each.value, "key_management_service", {})
    content {
      key_vault_key_id         = lookup(each.value.key_management_service, "key_vault_key_id", null)
      key_vault_network_access = lookup(each.value.key_management_service, "key_vault_network_access", "Public") #optional

    }
  }

  dynamic "key_vault_secrets_provider" {
    for_each = each.value.key_vault_secrets_provider != null ? [each.value.key_vault_secrets_provider] : []
    content {
      secret_rotation_enabled = lookup(each.value.key_vault_secrets_provider, "secret_rotation_enabled", false) #optional
      #secret_rotation_interval=""
    }
  }

  dynamic "kubelet_identity" {
    for_each = each.value.kubelet_identity != null ? [each.value.kubelet_identity] : []
    content {
      client_id                 = lookup(each.value.kubelet_identity, "client_id", null)                 #optional
      object_id                 = lookup(each.value.kubelet_identity, "object_id", null)                 #optional
      user_assigned_identity_id = lookup(each.value.kubelet_identity, "user_assigned_identity_id", null) #optional

    }
  }

  dynamic "microsoft_defender" {
    for_each = lookup(each.value, "microsoft_defender", {})
    content {
      log_analytics_workspace_id = lookup(each.value.microsoft_defender, "log_analytics_workspace_id", false) #optional
    }
  }

  dynamic "monitor_metrics" {
    for_each = lookup(each.value, "monitor_metrics", {})
    content {
      annotations_allowed = lookup(each.value.monitor_metrics, "annotations_allowed", []) #optional
      labels_allowed      = lookup(each.value.monitor_metrics, "labels_allowed", [])      #optional
    }
  }

  dynamic "network_profile" {
    for_each = each.value.network_profile != null ? [each.value.network_profile] : []
    content {
      network_plugin      = lookup(each.value.network_profile, "network_plugin", null)
      network_mode        = lookup(each.value.network_profile, "network_mode", null)             #optional
      network_policy      = lookup(each.value.network_profile, "network_policy", null)           #optional
      dns_service_ip      = lookup(each.value.network_profile, "dns_service_ip", null)           #optional
      network_data_plane  = lookup(each.value.network_profile, "network_data_plane", "azure")    #optional
      network_plugin_mode = lookup(each.value.network_profile, "network_plugin_mode", "overlay") #optional
      outbound_type       = lookup(each.value.network_profile, "outbound_type", "loadBalancer")  #optional
      pod_cidr            = lookup(each.value.network_profile, "pod_cidr", null)                 #optional
      pod_cidrs           = lookup(each.value.network_profile, "pod_cidrs", [])                  #optional
      service_cidr        = lookup(each.value.network_profile, "service_cidr", null)             #optional
      service_cidrs       = lookup(each.value.network_profile, "service_cidrs", [])              #optional

    }
  }

  dynamic "bootstrap_profile" {
    for_each = each.value.bootstrap_profile != null ? [each.value.bootstrap_profile] : []
    content {
      artifact_source       = lookup(each.value.bootstrap_profile, "artifact_source", null)       #optional
      container_registry_id = lookup(each.value.bootstrap_profile, "container_registry_id", null) #optional

    }
    }

     timeouts {
        create = "90m"
        update = "90m"
        delete = "90m"
      }

  

  #   dynamic "oms_agent" {
  #     for_each =lookup(each.value, "oms_agent", {})
  #     content {
  #       log_analytics_workspace_id="" 
  #       msi_auth_for_monitoring_enabled ="" #optional

  #     }
  #   }

  #  dynamic "service_mesh_profile" {
  #     for_each =lookup(each.value, "service_mesh_profile", {})
  #     content {
  #       mode="Istio"
  #       revisions=""
  #       internal_ingress_gateway_enabled =false #optional
  #       external_ingress_gateway_enabled=false #optional
  #       #certificate_authority="" #optional


  #     }
  #   }

  #  dynamic "workload_autoscaler_profile" {
  #     for_each =lookup(each.value, "workload_autoscaler_profile", {})
  #     content {
  #       keda_enabled =false #optional
  #       vertical_pod_autoscaler_enabled = false #optional

  #     }
  #   }

  # # This will not work because identity block is used
  #   # dynamic "service_principal" {
  #   #   for_each =lookup(each.value, "service_principal", {})
  #   #   content {}
  #   # }

  #  dynamic "storage_profile" {
  #     for_each =lookup(each.value, "storage_profile", {})
  #     content {
  #       blob_driver_enabled=false #optional
  #       disk_driver_enabled=true #optional
  #       file_driver_enabled=false
  #       snapshot_controller_enabled=true #optional

  #     }
  #   }

  #    dynamic "upgrade_override" {
  #     for_each =lookup(each.value, "upgrade_override", {})
  #     content {
  #       force_upgrade_enabled=false 
  #       effective_until="" #optional

  #     }
  #   }

  #   dynamic "web_app_routing" {
  #     for_each =lookup(each.value, "web_app_routing", {})
  #     content {
  #       dns_zone_ids =[] 
  #       default_nginx_controller = "AnnotationControlled" #optional

  #     }
  #   }

  #   dynamic "windows_profile" {
  #     for_each =lookup(each.value, "windows_profile", {})
  #     content {
  #       admin_username=""
  #       admin_password =""
  #       license ="" #optional

  #     }
  #   }

  #      tags = lookup(each.value, "tags", {})

}
