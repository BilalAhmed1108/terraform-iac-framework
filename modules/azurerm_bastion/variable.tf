variable "bastion" {
  description = "This is bastion network will be used in the entire project for VM access"

  type = map(object({
    name                   = string
    location               = string
    resource_group_name    = string
    copy_paste_enabled=optional(bool,true)
    file_copy_enabled=optional(bool,false)
    sku=optional(string,"Basic")
    ip_connect_enabled=optional(bool,false)
    kerberos_enabled=optional(bool,false)
    scale_units =optional(number,2)
    shareable_link_enabled=optional(bool,false)
    session_recording_enabled =optional(bool,false) 
    virtual_network_id =optional(string,null)
    zones = optional(list(string), null)   
    pipid= string
    subnetid= string

    ip_configuration = map(object({
      ip_configuration_name =string
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
    name                 = string
    v_n_n                = string
    r_g_n                = string
  }))
}