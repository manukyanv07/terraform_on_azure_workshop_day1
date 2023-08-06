terraform {
  required_providers {
    azapi = {
      source = "Azure/azapi"
    }
  }
}

provider "random" {}

provider "azapi" {
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
  }
}

resource "azurerm_resource_group" "eats_website_rg" {
  name     = "${var.name_prefix}-rg"
  location = var.main_location
}
