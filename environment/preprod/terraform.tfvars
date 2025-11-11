# Resouce group variable values
rgs = {
  rg1 = {
    name     = "BilalCorp-rg-1"
    location = "centralindia"
    #managed_by = "team devops"
    tags = {
      team_size = "4"
      team_lead = "Mr. X"
    }
  }

  rg2 = {
    name       = "BilalCorp-rg-2"
    location   = "australiaeast"
    managed_by = "team devops"
    #   tags = {
    #         team_size = "4"
    #       team_lead    = "Mr. X"   
    #     }
  }
}

# Storage variable values
stgs = {
  stg1 = {
    name                     = "bilalcorpstg1"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    kind                     = "StorageV2"

    access_tier               = "Hot"
    enable_https_traffic_only = true
    enable_shared_key_access  = true
    large_file_share_enabled  = false
    is_hns_enabled            = false
    allow_blob_public_access  = false

    min_tls_version = "TLS1_2"
    tags = {
      team_size = "4"
      team_lead = "Mr. X"
    }

    rg_key = "rg2"

    # network_rules is a map of named blocks; using a single named key "default" here
    network_rules = {
      default = {
        default_action = "Deny"
        # bypass = "Logging"
        ip_rules                   = []
        virtual_network_subnet_ids = []
      }
    }

    # identity as a named map (single item)
    identity = {
      primary = { type = "SystemAssigned"
        identity_ids = []
      }
    }

    # encryption as a named map
    encryption = {
      primary = { key_source = "Microsoft.Storage", key_vault_key_id = "" }
    }

    # static website example
    static_website = {
      site = { index_document = "index.html", error_404_document = "404.html", enabled = true }
    }

    # other blocks may be passed similarly, or empty map if not used:
    blob_properties         = {}
    queue_properties        = {}
    custom_domain           = {}
    immutability_policy     = {}
    delete_retention_policy = {}
  }

  stg2 = {
    name                     = "bilalcorpstg2"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    rg_key                   = "rg1"
  }
}

network = {
  network1 = {
    name          = "bilalcorp-vnet-1"
    address_space = ["10.0.0.0/16"]
    rg_key        = "rg2"
    bgp_community = null
    dns_servers   = []
    tags = {
      team_size = "4"
      team_lead = "Mr. X"
    }
    edge_zone                      = null
    flow_timeout_in_minutes        = 10
    private_endpoint_vnet_policies = "Disabled"
    ddos_protection_plan_id        = {}
    encryption = {
      encryption_enforcement = "AllowUnencrypted"
    }
    delegation = {
      delegation1 = {
        name         = "delegation-subnet1"
        service_name = "Microsoft.Web/serverFarms"
        actions      = ["Microsoft.Network/virtualNetworks/subnets/action"]
      }
    }

    # subnet={
    #   subnet1={
    #     subnet_name="backend-subnet"
    #     subnet_address_prefixes=["10.0.2.0/24"]

    # }

    # }
  }
  network2 = {
    name          = "bilalcorp-vnet-2"
    address_space = ["10.0.0.0/16"]
    rg_key        = "rg1"
    encryption    = {}
    subnet = {
      subnet1 = {
        subnet_name                                   = "frontend-subnet"
        subnet_address_prefixes                       = ["10.0.1.0/24"]
        security_group                                = null
        default_outbound_access_enabled               = true
        private_endpoint_network_policies             = "Enabled"
        private_link_service_network_policies_enabled = true
        route_table_id                                = null
        service_endpoints                             = []
      }

      subnet2 = {
        subnet_name             = "backend-subnet"
        subnet_address_prefixes = ["10.0.2.0/24"]
        # security_group=""
        # default_outbound_access_enabled=true
        # private_endpoint_network_policies="Enabled"
        # private_link_service_network_policies_enabled=true
        # route_table_id=""
        # service_endpoints=[]
      }

      subnet3 = {
        subnet_name             = "AzureBastionSubnet"
        subnet_address_prefixes = ["10.0.3.0/24"]
        # security_group=""
        # default_outbound_access_enabled=true
        # private_endpoint_network_policies="Enabled"
        # private_link_service_network_policies_enabled=true
        # route_table_id=""
        # service_endpoints=[]
      }
    }
  }
}

# Public ip values
pips = {
  pip1 = {
    name                    = "bilalcorp-pip-1"
    rg_key                  = "rg1"
    allocation_method       = "Static"
    zones                   = null
    ddos_protection_mode    = null
    ddos_protection_plan_id = null
    domain_name_label       = null
    edge_zone               = null
    idle_timeout_in_minutes = null
    ip_tags                 = null
    ip_version              = "IPv4"
    public_ip_prefix_id     = null
    reverse_fqdn            = null
    sku                     = "Standard"
    sku_tier                = null
    tags = {
      team_size = "4"
      team_lead = "Mr. X"
    }
  }
  pip2 = {
    name              = "bilalcorp-pip-2"
    rg_key            = "rg1"
    allocation_method = "Static"

    #   tags={
    #       team_size = "4"
    # team_lead    = "Mr. X"  
    #   }
  }
  pip3 = {
    name              = "bilalcorp-pip-3"
    rg_key            = "rg1"
    allocation_method = "Static"

  }
}

# Bastion host values
bastion = {
  bastion1 = {
    name                = "bastionhost"
    location            = "centralindia"
    resource_group_name = "BilalCorp-rg-1"
    pipid               = "bilalcorp-pip-1"
    subnetid            = "AzureBastionSubnet"
    ip_configuration = {
      ip_config_1 = {
        ip_configuration_name = "configuration"
      }
    }

  }
}

datapip = {
  bilalcorp-pip-1 = {
    name                = "bilalcorp-pip-1"
    resource_group_name = "BilalCorp-rg-1"
  }
}

datasubnet = {
  AzureBastionSubnet = {
    name  = "AzureBastionSubnet"
    v_n_n = "bilalcorp-vnet-2"
    r_g_n = "BilalCorp-rg-1"
  }
}

# Network Interface values
nic = {
  nic1 = {
    name                = "frontend-nic"
    location            = "centralindia"
    resource_group_name = "BilalCorp-rg-1"
    pipid               = "bilalcorp-pip-2"
    subnetid            = "frontend-subnet"
    ip_configurations = {
      ipconfig1 = {
        name = "ipconfig_frontnic"
      }
    }
    tags = {
      team_size = "4"
      team_lead = "Mr. X"
    }
  }
  nic2 = {
    name                = "backend-nic"
    location            = "centralindia"
    resource_group_name = "BilalCorp-rg-1"
    pipid               = "bilalcorp-pip-3"
    subnetid            = "backend-subnet"
    ip_configurations = {
      ipconfig1 = {
        name = "ipconfig_backnic"
      }
    }
    tags = {
      team_size = "4"
      team_lead = "Mr. X"
    }
  }
}

datapipnic = {
  bilalcorp-pip-2 = {
    name                = "bilalcorp-pip-2"
    resource_group_name = "BilalCorp-rg-1"
  }
  bilalcorp-pip-3 = {
    name                = "bilalcorp-pip-3"
    resource_group_name = "BilalCorp-rg-1"
  }
}

datasubnetnic = {
  frontend-subnet = {
    name  = "frontend-subnet"
    v_n_n = "bilalcorp-vnet-2"
    r_g_n = "BilalCorp-rg-1"
  }
  backend-subnet = {
    name  = "backend-subnet"
    v_n_n = "bilalcorp-vnet-2"
    r_g_n = "BilalCorp-rg-1"
  }
}


# Key Vault variable values
kv = {
  keyvaultbilalcorp = {
    name                        = "keyvaultbilalcorp"
    location                    = "centralindia"
    resource_group_name         = "BilalCorp-rg-1"
    enabled_for_disk_encryption = false
    soft_delete_retention_days  = 90
    #purge_protection_enabled=false
    #enabled_for_deployment=true
    #enabled_for_template_deployment=true
    public_network_access_enabled=true
    rbac_authorization_enabled= true
    tags = {
      team_size = "4"
      team_lead = "Mr. X"
    }
    sku_name                   = "standard"
    rbac_authorization_enabled = true
    network_acls = {
      bypass                     = "AzureServices"
      default_action             = "Allow"
      ip_rules                   = ["112.79.1.225"]
      virtual_network_subnet_ids = []
    }
    role_definition_name = "Key Vault Administrator"
  }
}


# Key Vault Secret variable values
kvsec = {
  vm1_username = {
    name  = "virtual-machine-frontend-username"
    value = "used"
    kvid="keyvaultbilalcorp"
    #value_wo=""
    #value_wo_version=""
    #content_type=""
    tags = {
      team_size = "4"
      team_lead = "Mr. X"
    }
    #not_before_date=""
    #expiration_date=""
  }
  vm2_username = {
    name  = "virtual-machine-backend-username"
    value = "used"
    kvid="keyvaultbilalcorp"
  }
    sql_server_username = {
    name  = "sql-server-username"
    value = "used"
    kvid="keyvaultbilalcorp"
  }
   vm1_password = {
    name  = "virtual-machine-frontend-password"
    value = "Smartuser123#"
    kvid="keyvaultbilalcorp"
  }
  vm2_password = {
    name  = "virtual-machine-backend-password"
    value = "Smartuser123#"
    kvid="keyvaultbilalcorp"
  }
  sql_server_password = {
    name  = "sql-server-password"
    value = "Smartuser123#"
    kvid="keyvaultbilalcorp"
}
}