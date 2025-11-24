# Calling resource group module       2 Resource Groups
module "azurerm_resource_group" {
  source = "../../modules/azurerm_resource_group"
  rgs    = var.rgs
}

# Calling Storage account module       2 Storage Accounts
module "azurerm_storage_account" {
  source     = "../../modules/azurerm_storage_account"
  stgs       = var.stgs
  rgname     = module.azurerm_resource_group.rgname
  rglocation = module.azurerm_resource_group.rglocation
}

# Calling Network module         2 Virtual Network with 3 Subnets in vnet 2
module "azurerm_network" {
  source     = "../../modules/azurerm_network"
  network    = var.network
  rgname     = module.azurerm_resource_group.rgname
  rglocation = module.azurerm_resource_group.rglocation
}

# Calling Public IP module             3 Public IPs, 1 for Bastion and 2 for NICs
module "azurerm_public_ip" {
  depends_on = [module.azurerm_network]
  source     = "../../modules/azurerm_public_ip"
  pips       = var.pips
  rgname     = module.azurerm_resource_group.rgname
  rglocation = module.azurerm_resource_group.rglocation
}


# Calling Bastion module        1 Bastion Host
module "azurerm_bastion" {
  depends_on = [module.azurerm_network, module.azurerm_public_ip]
  source     = "../../modules/azurerm_bastion"
  bastion    = var.bastion
  datapip    = var.datapip
  datasubnet = var.datasubnet
}

# Calling Network Interface Card module           2 NICs
module "azurerm_network_interface_card" {
  depends_on = [module.azurerm_network, module.azurerm_public_ip]
  source     = "../../modules/azurerm_network_interface_card"
  nic        = var.nic
  datapip    = var.datapipnic
  datasubnet = var.datasubnetnic
}

# Calling Key Vault module                1 key vault with 6 secrets (2 vm- username/password, 1 sqlserver - username/password)
module "azurerm_keyvault" {
  depends_on = [module.azurerm_resource_group]
  source     = "../../modules/azurerm_keyvault"
  kv         = var.kv
  kvsec      = var.kvsec
}

# Calling SQLServer module         1 SQL Server
module "azurerm_mysqlserver" {
  depends_on = [module.azurerm_resource_group, module.azurerm_keyvault]
  source     = "../../modules/azurerm_mysqlserver"
  sqlserver  = var.sqlserver
  keyvaultid = var.keyvaultid
  kvsec      = var.kvsec
}


# Call sqldatabase module
module "azurerm_database" {
  depends_on    = [module.azurerm_mysqlserver]
  source        = "../../modules/azurerm_database"
  database      = var.database
  sqlserverdata = var.sqlserverdata
}


#Calling Virtual machine module

module "azurerm_virtual_machine" {
  depends_on = [module.azurerm_keyvault, module.azurerm_network, module.azurerm_public_ip]
  source     = "../../modules/azurerm_virtual_machines"
  vms        = var.vms
  nicdata    = var.nicdata
  keyvaultid = var.keyvaultid
  kvsec      = var.kvsec
}

#Calling Kubernetes Cluster module  
module "azurerm_akc" {
  depends_on = [module.azurerm_resource_group, module.azurerm_network]
  source     = "../../modules/azurerm_akc"
  akc       = var.akc
}


# Calling Container Registry module

module "azurerm_akr" {
  depends_on = [ module.azurerm_akc]
  source     = "../../modules/azurerm_akr"
  akr = var.akr
}