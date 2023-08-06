resource "azurerm_service_plan" "eats_website_app_service_plan" {
  name                = "${var.name_prefix}-app-service-plan"
  location            = azurerm_resource_group.eats_website_rg.location
  resource_group_name = azurerm_resource_group.eats_website_rg.name
  os_type             = "Windows"
  sku_name            = "B2"
}

resource "azurerm_windows_web_app" "eats_website_as" {
  name                = var.name_prefix
  location            = azurerm_resource_group.eats_website_rg.location
  resource_group_name = azurerm_resource_group.eats_website_rg.name
  service_plan_id     = azurerm_service_plan.eats_website_app_service_plan.id

  site_config {
    always_on = false
    application_stack {
      dotnet_version = "v4.0"
      current_stack  = "dotnetcore"
    }

  }
  app_settings = {
    WEBSITE_NODE_DEFAULT_VERSION = "10.15.2"
    SCM_COMMAND_IDLE_TIMEOUT     = "1800"
    productImagesUrl             = "https://raw.githubusercontent.com/microsoft/TailwindTraders-Backend/master/Deploy/tailwindtraders-images/product-detail"
    ApiUrl                       = ""
    ApiUrlShoppingCart           = ""
    MongoConnectionString        = ""
    SqlConnectionString          = ""
    // "Server=tcp:${azurerm_mssql_server.eats_website.fully_qualified_domain_name},1433;Initial Catalog=${azurerm_mssql_database.test.name};Persist Security Info=False;User ID=${azurerm_mssql_server.eats_website.administrator_login};Password=${azurerm_mssql_server.eats_website.administrator_login_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
    Personalizer__ApiKey         = ""
    Personalizer__Endpoint       = ""
  }
}
