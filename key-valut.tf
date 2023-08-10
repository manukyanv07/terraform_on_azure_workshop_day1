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
  tenant_id    = "f0f1c7bc-abf1-4b1b-b5af-1dcfed5cef4f"
  object_id    = "960bda47-990b-4e69-92ff-e1bc3d7a52ba"
  lifecycle {
    create_before_destroy = true
  }

  key_permissions         = var.kv-key-permissions-full
  secret_permissions      = var.kv-secret-permissions-full
  certificate_permissions = var.kv-certificate-permissions-full
  storage_permissions     = var.kv-storage-permissions-full
}

resource "azurerm_key_vault_access_policy" "terraform_policy" {
  key_vault_id = azurerm_key_vault.eats_website_key_vault.id
  tenant_id    = "f0f1c7bc-abf1-4b1b-b5af-1dcfed5cef4f"
  object_id    = "8c7de9d9-8b22-446c-bae0-18a7c25ef1b9"
  #  application_id = "7c2fbb9a-bbeb-4576-b2f8-c2256108c9df"
  lifecycle {
    create_before_destroy = true
  }

  key_permissions         = var.kv-key-permissions-full
  secret_permissions      = var.kv-secret-permissions-full
  certificate_permissions = var.kv-certificate-permissions-full
  storage_permissions     = var.kv-storage-permissions-full
}
