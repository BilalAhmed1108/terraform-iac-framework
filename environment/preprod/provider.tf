terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.52.0"
    }
  }

   backend "azurerm" {
    resource_group_name = "RG-backend"
    storage_account_name        = "stginrg"                              
    container_name              = "container"                               
    key                         = "preprod.terraform.tfstate"                
  }
}

provider "azurerm" {
  features {}
  subscription_id = "c4392c89-177c-49fd-abc6-1b1d293e65b7"

}
