terraform {
  required_providers {
    azapi = {
      source = "Azure/azapi"
    }
  }
  backend "azurerm" {
    resource_group_name = "mansu-web-rg"
    container_name       = "tfstate"
    storage_account_name = "devops3dcb70f641"
    access_key = "uh58iyAAzlL/0Oa7ptgjaInbozH2pnnX/b5Fhod8XYNdMk4YNpi+L2q/pUKKYkubnv8PvCka8MMc+ASte+nVrg=="
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
