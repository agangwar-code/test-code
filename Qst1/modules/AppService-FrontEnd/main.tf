resource "azurerm_service_plan" "ASP-kpmg-9cd4" {
  name                = var.asp_name
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = var.os_type
  sku_name            = var.sku_name
  tags = {
    use = var.tier
  }
}

resource "azurerm_linux_web_app" "WebTier" {
  name                = var.AppService_name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.ASP-kpmg-9cd4.id

  site_config {
    always_on = true
    application_stack {
      node_version = var.node_version
    }
  }

  tags = {
    use = var.tier
  }
}

resource "azurerm_app_service_virtual_network_swift_connection" "AppService-Vnet-Integration" {
  app_service_id = azurerm_linux_web_app.WebTier.id
  subnet_id      = var.subnet_id_Vnet_Integration
}