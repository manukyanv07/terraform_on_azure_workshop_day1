output "sql_connection_string" {
  description = "Connection string for the Azure SQL Database created."
  sensitive   = true
  value       = "Server=tcp:${azurerm_mssql_server.eats_website.fully_qualified_domain_name},1433;Initial Catalog=${azurerm_mssql_database.test.name};Persist Security Info=False;User ID=${azurerm_mssql_server.eats_website.administrator_login};Password=${azurerm_mssql_server.eats_website.administrator_login_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
}
