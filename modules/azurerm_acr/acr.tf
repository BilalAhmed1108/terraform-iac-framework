resource "azurerm_container_registry" "acr" {
  name                = "BilalCorpRegistry"
  resource_group_name = "BilalCorp-rg-1"
  location            = "centralindia"
  sku                 = "Standard"
}