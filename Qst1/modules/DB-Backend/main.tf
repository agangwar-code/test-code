resource "azurerm_sql_server" "sql-server" {
  name                         = "${var.backend_prefix}-sql-server"
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = var.sql_server_version
  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password

  tags = {
    tier = var.tier
  }
}

resource "azurerm_sql_database" "db" {
  name                = "${var.backend_prefix}-db"
  resource_group_name = var.resource_group_name
  location            = var.location
  server_name         = azurerm_sql_server.sql-server.name
  create_mode         = var.create_mode
  edition             = var.edition

  tags = {
    tier = var.tier
  }
}

#resource "azurerm_sql_virtual_network_rule" "VNet-Rule" {
#  name                = "${var.backend_prefix}-sql-vnet-rule"
#  resource_group_name = var.resource_group_name
#  server_name         = azurerm_sql_server.sql-server.name
#  subnet_id           = var.subnet_id_internal
#}