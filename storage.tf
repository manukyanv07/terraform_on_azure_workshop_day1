resource "random_id" "random_id" {
  byte_length = 5
}
resource "azurerm_storage_account" "devops" {
  name                     = "devops${random_id.random_id.hex}"
  resource_group_name      = azurerm_resource_group.eats_website_rg.name
  location                 = azurerm_resource_group.eats_website_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = {
    environment = "dev"
  }
}
