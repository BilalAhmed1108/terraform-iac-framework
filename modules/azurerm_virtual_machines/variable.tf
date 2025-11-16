variable "vms" {
  type = map(object({
    name                                                   = string
    resource_group_name                                    = string
    location                                               = string
    size                                                   = string #"Standard_F2"
    disable_password_authentication                        = optional(bool, false)
    #vm_username= string
    #vm_password= string
    allow_extension_operations                             = optional(bool, true)  #true
    bypass_platform_safety_checks_on_user_schedule_enabled = optional(bool, false) #false
    availability_set_id                                    = optional(string)
    #patch_assessment_mode=optional(string)
    computer_name                                          = optional(string)
    custom_data                                            =optional(string,null)
    #custom_data                                            = optional(string)
    dedicated_host_id                                      = optional(string)
    dedicated_host_group_id                                = optional(string)
    disk_controller_type                                   = optional(string)
    edge_zone                                              = optional(string)
    encryption_at_host_enabled                             = optional(string)
    eviction_policy                                        = optional(string)
    extensions_time_budget                                 = optional(string)
    #patch_assessment_mode                                  = optional(string)
    #patch_mode                                             = optional(string)
    max_bid_price                                          = optional(string)
    platform_fault_domain                                  = optional(number)
    priority                                               = optional(string)
    provision_vm_agent                                     = optional(string)
    proximity_placement_group_id                           = optional(string)
    #reboot_setting                                         = optional(string)
    secure_boot_enabled                                    = optional(string)
    source_image_id                                        = optional(string)
    os_managed_disk_id                                     = optional(string)
    user_data                                              = optional(string,null)
    vtpm_enabled                                           = optional(string)
    virtual_machine_scale_set_id                           = optional(string)
    zone                                                   = optional(string)
    #source_image_reference =optional(string)
    capacity_reservation_group_id = optional(string)
    admin_ssh_keys                = optional(map(string))
    licence_type                  = optional(string)
nic_name=string
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

variable "keyvaultid" {
  type = map(object({
    name= string
    r_g_n=string
  }))
}

variable "kvsec" {
  type = map(object({
name=string
kvid = string

  }))
}

variable "nicdata" {
  type= map(object({
    name=string
    resource_group_name=string
  }))
}

