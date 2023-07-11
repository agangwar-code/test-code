output "AppService_hostname" {
  value = azurerm_linux_web_app.WebTier.default_hostname
}