resource "random_password" "sql_admin_password" {
  length           = 32
  override_special = "$·!#%&/()=?¿"
  min_special      = 12
}
resource "azurerm_key_vault_secret" "eats_website_db_admin_password" {
  name         = "${var.name_prefix}-sql-admin-password"
  value        = random_password.sql_admin_password.result
  key_vault_id = azurerm_key_vault.eats_website_key_vault.id
  depends_on   = [azurerm_key_vault_access_policy.default_policy]
}
resource "azurerm_mssql_server" "eats_website" {
  name                = "${var.name_prefix}-sql-server"
  resource_group_name = azurerm_resource_group.eats_website_rg.name
  location            = azurerm_resource_group.eats_website_rg.location
  version             = "12.0"
  administrator_login = "db_admin"

  administrator_login_password = random_password.sql_admin_password.result

  tags = {
    environment = "testing"
  }
}

resource "azurerm_mssql_database" "test" {
  name           = "${var.name_prefix}-db-d"
  server_id      = azurerm_mssql_server.eats_website.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  sku_name       = "Basic"

  tags = {
    Environment = "dev"
  }
}
