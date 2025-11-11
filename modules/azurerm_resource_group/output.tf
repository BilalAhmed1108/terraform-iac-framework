output "rgname" {
  value = { for k, rg in azurerm_resource_group.rg : k => rg.name}
}

output "rglocation" {
  value = { for k, rg in azurerm_resource_group.rg : k => rg.location}
}