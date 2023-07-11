output "Internal_Subnet_Id" {
  value = azurerm_subnet.Internal-Subnet.id
}

output "VNet_Integration_Subnet" {
  value = azurerm_subnet.VNet-Integration-Subnet.id
}