resource "random_id" "app_id" {
  byte_length = 16
}

resource "random_password" "github_app_password" {
  length           = 32
  override_special = "$·!#%&/()=?¿"
  min_special      = 12
}
resource "azurerm_key_vault_secret" "github_app_service_principal_password" {
  name         = "${var.name_prefix}-github-app-password"
  value        = random_password.github_app_password.result
  key_vault_id = azurerm_key_vault.eats_website_key_vault.id
  depends_on   = [azurerm_key_vault_access_policy.default_policy]
}

resource "azurerm_service_principal" "github" {
  application_id                   = random_id.app_id.hex
  display_name                     = "gh-actions-terraform"
  password                         = random_password.github_app_password.result
  skip_service_principal_aad_check = true
}
resource "azurerm_role_assignment" "github_tf" {
  principal_id         = azurerm_service_principal.github.id
  role_definition_name = "Contributor"  # Or the appropriate role
  scope                = "/subscriptions/your-subscription-id"  # Replace with your Subscription ID
}
