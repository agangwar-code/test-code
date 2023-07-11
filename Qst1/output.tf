output "AppService_hostname" {
  value = module.AppService-FrontEnd.AppService_hostname
}

output "sql-server-fully-qualified-domain-name" {
  value = module.DB-Backend.sql-server-fully-qualified-domain-name
}

output "Internal_Subnet_Id" {
  value = module.VM-ApplicationTier.Internal_Subnet_Id
}

output "VNet_Integration_Subnet" {
  value = module.VM-ApplicationTier.VNet_Integration_Subnet
}