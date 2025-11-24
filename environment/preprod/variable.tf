# Resource group variable
variable "rgs" {
  description = "Name of all the resource groups of the project"
  type = map(object({
    name       = string
    location   = string
    managed_by = optional(string)
    tags       = optional(map(string))
  }))
}


# Storage account variable
variable "stgs" {
  description = "Map of storage account definitions keyed by identifier"
  type = map(object({
    name                              = string
    account_kind                      = optional(string)
    account_tier                      = string
    account_replication_type          = string
    provisioned_billing_model_version = optional(string)
    cross_tenant_replication_enabled  = optional(bool)
    access_tier                       = optional(string)
    edge_zone                         = optional(string)
    https_traffic_only_enabled        = optional(bool)
    min_tls_version                   = optional(string)
    allow_nested_items_to_be_public   = optional(bool)
    shared_access_key_enabled         = optional(bool)
    public_network_access_enabled     = optional(bool)
    default_to_oauth_authentication   = optional(bool)
    is_hns_enabled                    = optional(bool)
    nfsv3_enabled                     = optional(bool)

    customer_managed_key = optional(map(object({
      key_vault_key_id          = optional(string)
      managed_hsm_key_id        = optional(string)
      user_assigned_identity_id = string
    })))

    identity = optional(map(object({
      type         = string
      identity_ids = optional(list(string))
    })))

    static_website = optional(map(object({
      index_document     = optional(string)
      error_404_document = optional(string)
    })))

    network_rules = optional(map(object({
      default_action = string
      # bypass=optional(string)
      ip_rules                   = optional(list(string))
      virtual_network_subnet_ids = optional(list(string))
    })))

    large_file_share_enabled          = optional(bool)
    local_user_enabled                = optional(bool)
    queue_encryption_key_type         = optional(string)
    table_encryption_key_type         = optional(string)
    infrastructure_encryption_enabled = optional(bool)
    allowed_copy_scope                = optional(string)
    sftp_enabled                      = optional(bool)
    dns_endpoint_type                 = optional(string)
    tags                              = optional(map(string))
    rg_key                            = string

  }))
}

# Network variable
variable "network" {
  description = "This contains the virtual network and subnet configurations of the entire project"
  type = map(object({
    name                           = string
    address_space                  = list(string)
    rg_key                         = string
    bgp_community                  = optional(string)
    dns_servers                    = optional(list(string))
    tags                           = optional(map(string))
    #edge_zone                      = optional(string)
    flow_timeout_in_minutes        = optional(number, 10)
    private_endpoint_vnet_policies = optional(string, "Disabled")
    ddos_protection_plan_id        = optional(map(string))
    encryption                     = optional(map(string))
    delegation = optional(map(object({
      name         = string
      service_name = string
      actions      = list(string)
    })))

    subnet = optional(map(object({
      subnet_name                                   = optional(string, "default-subnet")
      subnet_address_prefixes                       = list(string)
      security_group                                = optional(string)
      default_outbound_access_enabled               = optional(bool, true)
      private_endpoint_network_policies             = optional(string, "Enabled")
      private_link_service_network_policies_enabled = optional(bool, true)
      route_table_id                                = optional(string)
      service_endpoints                             = optional(list(string))
    })), {})

  }))
}

# Public ip variable
variable "pips" {
  description = " All public ips isesd in the project"
  type = map(object({
    name                    = string
    rg_key                  = string
    allocation_method       = string
    zones                   = optional(list(string))
    ddos_protection_mode    = optional(string, "Disabled")
    ddos_protection_plan_id = optional(string)
    domain_name_label       = optional(string)
    edge_zone               = optional(string)
    idle_timeout_in_minutes = optional(number, 4)
    ip_tags                 = optional(map(string))
    ip_version              = optional(string, "IPv4")
    public_ip_prefix_id     = optional(string)
    reverse_fqdn            = optional(string)
    sku                     = optional(string, "Standard")
    sku_tier                = optional(string, "Regional")
    tags                    = optional(map(string))
  }))
}

# Bastion variable
variable "bastion" {
  description = "This is bastion network will be used in the entire project for VM access"

  type = map(object({
    name                      = string
    location                  = string
    resource_group_name       = string
    copy_paste_enabled        = optional(bool, true)
    file_copy_enabled         = optional(bool, false)
    sku                       = optional(string, "Basic")
    ip_connect_enabled        = optional(bool, false)
    kerberos_enabled          = optional(bool, false)
    scale_units               = optional(number, 2)
    shareable_link_enabled    = optional(bool, false)
    session_recording_enabled = optional(bool, false)
    virtual_network_id        = optional(string, null)
    zones                     = optional(list(string), null)
    pipid                     = string
    subnetid                  = string
    ip_configuration = map(object({
      ip_configuration_name = string
      # subnet_id            = string
      # public_ip_address_id = string

    }))
  }))
}

variable "datapip" {
  type = map(object({
    name                = string
    resource_group_name = string
  }))
}
variable "datasubnet" {
  type = map(object({
    name  = string
    v_n_n = string
    r_g_n = string
  }))
}

# Network Interface Card variable
variable "nic" {
  type = map(object({
    name                           = string
    location                       = string
    resource_group_name            = string
    auxiliary_mode                 = optional(string)
    auxiliary_sku                  = optional(string)
    tags                           = optional(map(string))
    dns_servers                    = optional(list(string))
    edge_zone                      = optional(string)
    ip_forwarding_enabled          = optional(bool)
    accelerated_networking_enabled = optional(bool)
    pipid                          = string
    subnetid                       = string
    internal_dns_name_label        = optional(string)
    ip_configurations = map(object({
      name                                               = string
      gateway_load_balancer_frontend_ip_configuration_id = optional(string)
      private_ip_address_version                         = optional(string)
      private_ip_address_allocation                      = optional(string)
      primary                                            = optional(bool)
    }))
  }))
}

variable "datapipnic" {
  type = map(object({
    name                = string
    resource_group_name = string
  }))
}
variable "datasubnetnic" {
  type = map(object({
    name  = string
    v_n_n = string
    r_g_n = string
  }))
}

# Key Vault variable
variable "kv" {
  type = map(object({
    name                            = string
    location                        = string
    resource_group_name             = string
    enabled_for_disk_encryption     = optional(bool)        #true
    soft_delete_retention_days      = optional(number)      #
    purge_protection_enabled        = optional(bool)        # false
    enabled_for_deployment          = optional(bool)        # true
    enabled_for_template_deployment = optional(bool)        # true
    public_network_access_enabled   = optional(bool)        # true
    tags                            = optional(map(string)) # {}
    sku_name                        = string                # standard
    rbac_authorization_enabled      = bool                  # true
    network_acls = optional(object({
      bypass                     = string                 # None
      default_action             = string                 # Deny
      ip_rules                   = optional(list(string)) # []
      virtual_network_subnet_ids = optional(list(string)) # []
    }))

    role_definition_name = string
  }))
}


# Key Vault Secret variable
variable "kvsec" {
  type = map(object({
    name             = string
    value            = optional(string)
    value_wo         = optional(string)
    value_wo_version = optional(string)
    content_type     = optional(string)
    tags             = optional(map(string))
    not_before_date  = optional(string)
    expiration_date  = optional(string)
    kvid             = string
  }))
}

# SQL Server variable
variable "sqlserver" {
  type = map(object({
    name                                         = string
    resource_group_name                          = string
    location                                     = string
    version                                      = string
    sql_password                                 = string
    sql_username                                 = string
    minimum_tls_version                          = optional(string)
    administrator_login_password_wo              = optional(string)
    administrator_login_password_wo_version      = optional(string)
    connection_policy                            = optional(string)
    express_vulnerability_assessment_enabled     = optional(bool)
    transparent_data_encryption_key_vault_key_id = optional(string)
    public_network_access_enabled                = optional(bool)
    outbound_traffic_enabled                     = optional(bool)
    primary_user_assigned_identity_id            = optional(string)
    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))
    azuread_administrator = optional(object({
      login_username              = string
      object_id                   = string
      tenant_id                   = optional(string)
      azuread_authentication_only = optional(bool)
    }))
    tags = optional(map(string))
  }))

}

variable "keyvaultid" {
  type = map(object({
    r_g_n = string
    name  = string
  }))

}


# SQL Database variable
variable "database" {
  type = map(object({
    name                                                       = optional(string)
    auto_pause_delay_in_minutes                                = optional(string)
    collation                                                  = optional(string)
    license_type                                               = optional(string)
    max_size_gb                                                = optional(string)
    sku_name                                                   = optional(string)
    enclave_type                                               = optional(string)
    create_mode                                                = optional(string)
    creation_source_database_id                                = optional(string)
    elastic_pool_id                                            = optional(string)
    geo_backup_enabled                                         = optional(string)
    maintenance_configuration_name                             = optional(string)
    ledger_enabled                                             = optional(bool)
    min_capacity                                               = optional(string)
    restore_point_in_time                                      = optional(string)
    recover_database_id                                        = optional(string)
    recovery_point_id                                          = optional(string)
    restore_dropped_database_id                                = optional(string)
    restore_long_term_retention_backup_id                      = optional(string)
    read_replica_count                                         = optional(string)
    read_scale                                                 = optional(string)
    sample_name                                                = optional(string)
    storage_account_type                                       = optional(string)
    transparent_data_encryption_enabled                        = optional(bool)
    transparent_data_encryption_key_vault_key_id               = optional(string)
    transparent_data_encryption_key_automatic_rotation_enabled = optional(bool)
    zone_redundant                                             = optional(bool)
    secondary_type                                             = optional(string)

    tags = optional(map(string))
  }))
}

variable "sqlserverdata" {
  type = map(object({
    name  = string
    r_g_n = string
  }))
}

# Virtual machine variable
variable "vms" {
  type = map(object({
    name                            = string
    resource_group_name             = string
    location                        = string
    size                            = string #"Standard_F2"
    disable_password_authentication = optional(bool, false)
    #vm_username= string
    #vm_password= string
    allow_extension_operations                             = optional(bool, true)  #true
    bypass_platform_safety_checks_on_user_schedule_enabled = optional(bool, false) #false
    availability_set_id                                    = optional(string)
    #patch_assessment_mode=optional(string)
    computer_name = optional(string)
    custom_data   = optional(string, null)
    #custom_data                                            = optional(string)
    dedicated_host_id          = optional(string)
    dedicated_host_group_id    = optional(string)
    disk_controller_type       = optional(string)
    edge_zone                  = optional(string)
    encryption_at_host_enabled = optional(string)
    eviction_policy            = optional(string)
    extensions_time_budget     = optional(string)
    #patch_assessment_mode                                  = optional(string)
    #patch_mode                                             = optional(string)
    max_bid_price                = optional(string)
    platform_fault_domain        = optional(number)
    priority                     = optional(string)
    provision_vm_agent           = optional(string)
    proximity_placement_group_id = optional(string)
    #reboot_setting                                         = optional(string)
    secure_boot_enabled          = optional(string)
    source_image_id              = optional(string)
    os_managed_disk_id           = optional(string)
    user_data                    = optional(string, null)
    vtpm_enabled                 = optional(string)
    virtual_machine_scale_set_id = optional(string)
    zone                         = optional(string)
    #source_image_reference =optional(string)
    capacity_reservation_group_id = optional(string)
    admin_ssh_keys                = optional(map(string))
    licence_type                  = optional(string)
    nic_name                      = string
    os_disk = map(object({
      caching              = string
      storage_account_type = string
    }))

    source_image_reference = map(object({
      publisher = string
      offer     = string
      sku       = string
      version   = string

    }))

    additional_capabilities = optional(map(object({
      ultra_ssd_enabled   = string
      hibernation_enabled = string
    })), {})

    boot_diagnostics = optional(map(object({
      storage_account_uri = string
    })), {})
  }))


}

variable "nicdata" {
  type = map(object({
    name                = string
    resource_group_name = string

  }))
}

# AKC variable
 variable "akc" {
    description = "A map of AKS clusters"
    type = map(object({
        name                = string
        location            = string
        resource_group_name = string
        dns_prefix          = string
        #automatic_upgrade_channel = optional(string, "none")
        azure_policy_enabled = optional(bool)
        cost_analysis_enabled = optional(bool, false)
        custom_ca_trust_certificates_base64 = optional(list(string), [])
        #disk_encryption_set_id = optional(string, "")
        edge_zone = optional(string, null)
        http_application_routing_enabled = optional(bool)
        image_cleaner_enabled = optional(bool)
        image_cleaner_interval_hours = optional(number)
        kubernetes_version = optional(string)
        local_account_disabled = optional(bool, false)
        node_os_upgrade_channel = optional(string, "None")
        node_resource_group = optional(string, null)
        oidc_issuer_enabled = optional(bool)
        open_service_mesh_enabled = optional(bool, false)
        private_cluster_enabled = optional(bool, false)
        private_dns_zone_id = optional(string, null)
        private_cluster_public_fqdn_enabled = optional(bool, false)
        #ai_toolchain_operator_enabled = optional(bool, false)
        workload_identity_enabled = optional(bool, false)
        role_based_access_control_enabled = optional(bool, true)
        run_command_enabled = optional(bool, true)
        sku_tier = optional(string, "Free")
        support_plan = optional(string, "KubernetesOfficial")


        default_node_pool   = optional(object({
        name                        = optional(string)
        node_count                  = optional(number, 1)
        vm_size                     = optional(string)
        capacity_reservation_group_id = optional(string)
        auto_scaling_enabled        = optional(bool, false)
        host_encryption_enabled     = optional(bool, false)
        node_public_ip_enabled      = optional(bool, false)
        gpu_instance                = optional(string, null)
        host_group_id               = optional(string, null)
        fips_enabled                = optional(bool, false)
        kubelet_disk_type           = optional(string, "optional")
        max_pods                    = optional(number)
        node_public_ip_prefix_id    = optional(string, null)
        #node_labels                 = optional(map(string), {})
        only_critical_addons_enabled= optional(bool, false)
        orchestrator_version        = optional(string)
        os_disk_size_gb             = optional(number)
        os_disk_type                = optional(string, "Managed")
        os_sku                      = optional(string, "Ubuntu")
        pod_subnet_id               = optional(string, null)
        proximity_placement_group_id= optional(string, null)
        scale_down_mode             = optional(string, "Delete")
        snapshot_id                 = optional(string, null)
        temporary_name_for_rotation = optional(string, null)
        type                        = optional(string, "VirtualMachineScaleSets")
        ultra_ssd_enabled           = optional(bool, false)
        vnet_subnet_id              = optional(string, null)
        workload_runtime            = optional(string, "OCIContainer")
        zones                       = optional(list(string))
        }))

        identity = optional(object({
            type                     = string
            identity_ids= optional(list(string))
    }))
    
    api_server_access_profile = optional(object({
        authorized_ip_ranges = optional(list(string))
        enable_private_cluster_public_fqdn = optional(bool, false)
        virtual_network_integration_enabled = optional(bool, false)
    }))

    auto_scaler_profile = optional(map(object({
        balance_similar_node_groups = optional(string)
        daemonset_eviction_for_empty_nodes_enabled = optional(string)   
        daemonset_eviction_for_occupied_nodes_enabled = optional(string)
        expander = optional(string) 
         ignore_daemonsets_utilization_enabled = optional(string)
         max_graceful_termination_sec= optional(string)
          max_node_provisioning_time = optional(string)
           max_unready_nodes = optional(string)
           max_unready_percentage = optional(string)
        scale_down_delay_after_add = optional(string)
         scale_down_delay_after_delete = optional(string)
         scale_down_delay_after_failure = optional(string)
        scan_interval = optional(string)
         scale_down_unneeded = optional(string)
         scale_down_unready = optional(string)
        scale_down_utilization_threshold = optional(string)
        empty_bulk_delete_max= optional(string)
        skip_nodes_with_local_storage= optional(string, false)
        skip_nodes_with_system_pods= optional(string,true)
       
        })))

        azure_active_directory_role_based_access_control = optional(object({
            admin_group_object_ids = optional(list(string))
            managed                = optional(bool, true)
            tenant_id              = optional(string)
        }))

        confidential_computing = optional(object({
            sgx_quote_helper_enabled = optional(bool, false)
    }))

    http_proxy_config = optional(object({
        http_proxy  = optional(string)
        https_proxy = optional(string)
        no_proxy    = optional(string)
        trusted_ca= optional(string)
    }))

    ingress_application_gateway = optional(object({
        gateway_id                     = optional(string)
        subnet_id                   = optional(string)
        gateway_name                = optional(string)
        subnet_cidr                     = optional(string)
    }))

key_vault_secrets_provider = optional(object({
        secret_rotation_enabled= optional(bool,false)
    }))

kubelet_identity = optional(object({
        client_id  = optional(string)
        object_id = optional(string)
        user_assigned_identity_id = optional(string)

    }))

    microsoft_defender_for_cloud = optional(object({
        log_analytics_workspace_ids= optional(bool)

    }))

    key_management = optional(object({
        annotations_allowed = optional(list(string))
        labels_allowed = optional(list(string))
    }))

network_profile = optional(object({
    network_plugin = string
    network_mode = optional(string, null)
    network_policy = optional(string)
     dns_service_ip = optional(string, null)
     network_data_plane = optional(string, null)
     network_plugin_mode = optional(string, null)
     outbound_type = optional(string, null)
     pod_cidr = optional(string, null)
     pod_cidrs = optional(list(string))
     service_cidr = optional(string, null)
     service_cidrs = optional(list(string))

}))


bootstrap_profile = optional(object({
    artifact_source = optional(string,"Direct")
    container_registry_id = optional(string,null)

}))



}))
 }

# ACR variable
variable "akr" {
  type = map(object({
    name                          = string
    resource_group_name           = string
    location                      = string
    sku                           = string
    admin_enabled                 = optional(bool)
    tags                          = optional(map(string))
    public_network_access_enabled = optional(bool)
    quarantine_policy_enabled     = optional(bool)
    retention_policy_in_days      = optional(number)
    trust_policy_enabled          = optional(bool)
    zone_redundancy_enabled       = optional(bool)
    export_policy_enabled         = optional(bool)
    anonymous_pull_enabled        = optional(bool)
    data_endpoint_enabled         = optional(bool)
    network_rule_bypass_option    = optional(string)


    georeplications = optional(list(object({
      location                  = string
      regional_endpoint_enabled = optional(bool)
      zone_redundancy_enabled   = optional(bool)
    })))


    network_rule_set = optional(object({
      default_action = optional(string)
    }))


    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))


    encryption = optional(object({
      key_vault_key_id   = string
      identity_client_id = optional(string)
    }))


  }))
}










