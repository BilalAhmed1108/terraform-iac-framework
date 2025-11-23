 variable "akc" {
    description = "A map of AKS clusters"
    type = map(object({
        name                = string
        location            = string
        resource_group_name = string
        dns_prefix          = string
        #automatic_upgrade_channel = optional(string, null)
        azure_policy_enabled = optional(bool)
        cost_analysis_enabled = optional(bool, false)
        custom_ca_trust_certificates_base64 = optional(list(string), [])
        #disk_encryption_set_id = optional(string, null)
       # edge_zone = optional(string, null)
        http_application_routing_enabled = optional(bool)
        image_cleaner_enabled = optional(bool)
        image_cleaner_interval_hours = optional(number)
        kubernetes_version = optional(string)
        local_account_disabled = optional(bool, false)
        node_os_upgrade_channel = optional(string, null)
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
        kubelet_disk_type           = optional(string, null)
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



