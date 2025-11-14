resource "azurerm_linux_virtual_machine" "vm" {
    for_each = var.vms
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  size                = each.value.size
  admin_username      = data.azurerm_key_vault_secret.keyvaultsecret[each.value.vm_username].value
  admin_password = data.azurerm_key_vault_secret.keyvaultsecret[each.value.userpassword].value      
  license_type= each.value.licence_type
  disable_password_authentication = lookup(each.value, "disable_password_authentication", false)
  allow_extension_operations =each.value.allow_extension_operations
  availability_set_id=each.value.availability_set_id
  bypass_platform_safety_checks_on_user_schedule_enabled =each.value.bypass_platform_safety_checks_on_user_schedule_enabled
  capacity_reservation_group_id =each.value.capacity_reservation_group_id
  computer_name=each.value.computer_name
  custom_data =each.value.custom_data
  dedicated_host_id=each.value.dedicated_host_id
  dedicated_host_group_id =each.value.dedicated_host_group_id
  disk_controller_type=each.value.disk_controller_type
  edge_zone=each.value.edge_zone
  encryption_at_host_enabled=each.value.encryption_at_host_enabled
  eviction_policy =each.value.eviction_policy
  extensions_time_budget =each.value.extensions_time_budget
  patch_assessment_mode=each.value.patch_assesment_mode
  patch_mode =each.value.patch_mode
  max_bid_price =each.value.max_bid_price
 platform_fault_domain =each.value.platform_fault_domain
 priority=each.value.priority
  provision_vm_agent=each.value.provision_vm_agent
  proximity_placement_group_id=each.value.proximity_placement_group_id
  #reboot_setting=each.value.reboot_settings
  secure_boot_enabled =each.value.secure_boot_enabled
  source_image_id =each.value.source_image_id
  os_managed_disk_id =each.value.os_managed_disk_id
  user_data =each.value.user_data
  vtpm_enabled =each.value.vtpm_enabled
  virtual_machine_scale_set_id=each.value.virtual_machine_scale_set_id
  zone=each.value.zone
  #source_image_reference =""
  network_interface_ids = [
    data.azurerm_network_interface.nicdata[each.value.nic_name].id,
  ]

#   admin_ssh_key {
#     username   = "adminuser"
#     public_key = file("~/.ssh/id_rsa.pub")
#   }

  dynamic "os_disk" {
    for_each = lookup(each.value, "os_disk", {})
    content {
      caching              = lookup(os_disk.value, "caching", null)
    storage_account_type = lookup(os_disk.value, "storage_account_type", null)
    }
    
  }

  dynamic "source_image_reference" {
    for_each = lookup(each.value, "source_image_reference", {})
    content {
    publisher = lookup(source_image_reference.value, "publisher", null)
    offer     = lookup(source_image_reference.value, "offer", null)
    sku       = lookup(source_image_reference.value, "sku", null)
    version   = lookup(source_image_reference.value, "version", null)
  }
    }
 

  dynamic "additional_capabilities" {
    for_each = lookup(each.value, "additional_capabilities", {})
    content {
    ultra_ssd_enabled = lookup(additional_capabilities.value, "ultra_ssd_enabled", false)
    hibernation_enabled =lookup(additional_capabilities.value, "hibernation_enabled",false)
    }

    }
dynamic "boot_diagnostics" {
    for_each = lookup(each.value, "boot_diagnostics", {})
    content {
     storage_account_uri = lookup(boot_diagnostics.value, "boot_diagnostics", null)
    }
}
}


