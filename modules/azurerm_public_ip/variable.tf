variable "pips"{
    description = " All public ips isesd in the project"
    type = map(object({
        name=string
        allocation_method=string
        rg_key=string
        zones=optional(list(string))
        ddos_protection_mode=optional(string,"Disabled")  
          ddos_protection_plan_id=optional(string)
       domain_name_label =optional(string)  
       edge_zone=optional(string)
       idle_timeout_in_minutes =optional(number,4)  
       ip_tags =optional(map(string)) 
       ip_version =optional(string,"IPv4")  
       public_ip_prefix_id =optional(string)    
       reverse_fqdn =optional(string) 
         sku =optional(string,"Standard")  
       sku_tier=optional(string,"Regional") 
        tags=optional(map(string))
    }))
}
variable "rglocation" {}
variable "rgname" {}