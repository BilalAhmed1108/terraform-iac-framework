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
    edge_zone                      = optional(string)
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
    enabled_for_disk_encryption     = optional(bool)                  #true
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

    role_definition_name           = string
  }))
}


# Key Vault Secret variable
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