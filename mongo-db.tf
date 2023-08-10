resource "random_password" "mongo_admin_password" {
  length           = 32
  override_special = "$·!#&/()=?¿"
  min_special      = 12
}
resource "azurerm_key_vault_secret" "eats_website_mongo_admin_password" {
  name         = "${var.name_prefix}-mongo-admin-password"
  value        = random_password.mongo_admin_password.result
  key_vault_id = azurerm_key_vault.eats_website_key_vault.id
  depends_on   = [azurerm_key_vault_access_policy.default_policy]
}
resource "azurerm_container_group" "eats_website_mongo_container" {
  name                = "mongodb-container"
  location            = azurerm_resource_group.eats_website_rg.location
  resource_group_name = azurerm_resource_group.eats_website_rg.name
  os_type             = "Linux"

  container {
    name   = "mongodb"
    image  = "mongo"
    cpu    = "0.5"
    memory = "1.5"

    environment_variables = {
      MONGO_INITDB_ROOT_USERNAME = "admin"
      MONGO_INITDB_ROOT_PASSWORD = random_password.mongo_admin_password.result
    }

    ports {
      port     = 27017
      protocol = "TCP"
    }

    commands = [
      "mongod",
      "--bind_ip",
      "0.0.0.0",
      "--auth"
    ]
  }

  tags = {
    Environment = "dev"
  }
}
