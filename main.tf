terraform {
  required_providers {
    azapi = {
      source = "Azure/azapi"
    }
  }
  backend "azurerm" {
    resource_group_name = "devops"
    container_name       = "tfstate"
    storage_account_name = "terraformtfstate939348"
    access_key = "feoL6HsHmjFnlWSiVdDBbSB9qACGfGehWgjvCNbItxOTkphfYztp8RsnBQL7fM0iVFYHDyhwbtLY+ASt9A1Hag=="
    key = "terraform.tfstate"
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
