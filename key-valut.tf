data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "eats_website_key_vault" {
  name                        = "${var.name_prefix}-vault"
  location                    = azurerm_resource_group.eats_website_rg.location
  resource_group_name         = azurerm_resource_group.eats_website_rg.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"
}

resource "azurerm_key_vault_access_policy" "default_policy" {
  key_vault_id = azurerm_key_vault.eats_website_key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  lifecycle {
    create_before_destroy = true
  }

  key_permissions         = var.kv-key-permissions-full
  secret_permissions      = var.kv-secret-permissions-full
  certificate_permissions = var.kv-certificate-permissions-full
  storage_permissions     = var.kv-storage-permissions-full
}

data "azuread_service_principal" "terraform_service_principal" {
  display_name = "github-actions"
}
resource "azurerm_key_vault_access_policy" "terraform_access_policy" {
  key_vault_id = azurerm_key_vault.eats_website_key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azuread_service_principal.terraform_service_principal.object_id

  lifecycle {
    create_before_destroy = true
  }

  key_permissions         = var.kv-key-permissions-full
  secret_permissions      = var.kv-secret-permissions-full
  certificate_permissions = var.kv-certificate-permissions-full
  storage_permissions     = var.kv-storage-permissions-full
}

