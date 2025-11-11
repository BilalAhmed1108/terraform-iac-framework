variable "nic" {
    type = map(object({
        name                = string
        location            = string
        resource_group_name = string
        auxiliary_mode      = optional(string)
        auxiliary_sku       = optional(string)
        tags                = optional(map(string))
        dns_servers         = optional(list(string))
        edge_zone           = optional(string)
        ip_forwarding_enabled = optional(bool)
        accelerated_networking_enabled = optional(bool)
          pipid=string
        subnetid=string 
        internal_dns_name_label = optional(string)
        ip_configurations  = map(object({
            name                                    = optional(string, "internal")
            gateway_load_balancer_frontend_ip_configuration_id = optional(string)
            private_ip_address_version              = optional(string,"IPv4")
            private_ip_address_allocation           = optional(string, "Dynamic")
            primary                                 = optional(bool, true)
        }))
    }))
}
variable "datapip" {}
variable "datasubnet" {}