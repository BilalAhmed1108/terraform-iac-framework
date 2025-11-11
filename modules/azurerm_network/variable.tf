variable "network" {
  description = "This contains the virtual network and subnet configurations of the entire project"
  type = map(object({
    name=string
  address_space=list(string)
   rg_key=string
    bgp_community=optional(string)
    dns_servers=optional(list(string))
    tags=optional(map(string))
    edge_zone=optional(string)
    flow_timeout_in_minutes=optional(number,10)
    private_endpoint_vnet_policies=optional(string,"Disabled")
    ddos_protection_plan_id=optional(map(string))
    encryption=optional(map(string))
    delegation=optional(map(object({
      name=string
      service_name=string
      actions=list(string)
    })))

    subnet=optional(map(object({
      subnet_name=string
      subnet_address_prefixes=list(string)
    security_group=optional(string)
      default_outbound_access_enabled=optional(bool,true)
      private_endpoint_network_policies=optional(string,"Enabled")
      private_link_service_network_policies_enabled=optional(bool,true)
      route_table_id=optional(string)
      service_endpoints=optional(list(string))
    })))

  }))


}

variable "rglocation" {}
variable "rgname" {}


