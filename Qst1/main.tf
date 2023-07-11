module "VM-ApplicationTier" {
  source                           = "./modules/VM-ApplicationTier"
  resource_group_name              = var.resource_group_name
  location                         = var.location
  prefix                           = var.prefix
  address_prefix                   = var.address_prefix
  address_space                    = var.address_space
  tier                             = var.tier
  vm_size                          = var.vm_size
  delete_os_disk_on_termination    = var.delete_os_disk_on_termination
  publisher                        = var.publisher
  offer                            = var.offer
  sku                              = var.sku
  image_version                    = var.image_version
  os_disk_caching                  = var.os_disk_caching
  os_create_option                 = var.os_create_option
  os_disk_type                     = var.os_disk_type
  vm_hostname                      = var.vm_hostname
  vm_admin_password                = var.vm_admin_password
  vm_admin_username                = var.vm_admin_username
  priority                         = var.priority
  direction                        = var.direction
  access                           = var.access
  protocol                         = var.protocol
  source_port_range                = var.source_port_range
  destination_port_range           = var.destination_port_range
  source_address_prefix            = var.source_address_prefix
  destination_address_prefix       = var.destination_address_prefix
  InternalSubnet_service_endpoints = var.InternalSubnet_service_endpoints
  VNet_Integration_Subnet          = var.VNet_Integration_Subnet
  address_prefix_VNet_Integration  = var.address_prefix_VNet_Integration
  service_endpoint_web             = var.service_endpoint_web
}

module "AppService-FrontEnd" {
  source                     = "./modules/AppService-FrontEnd"
  asp_name                   = var.asp_name
  resource_group_name        = var.resource_group_name
  location                   = var.location
  os_type                    = var.os_type
  sku_name                   = var.sku_name
  tier                       = var.tier
  AppService_name            = var.AppService_name
  node_version               = var.node_version
  subnet_id_Vnet_Integration = module.VM-ApplicationTier.VNet_Integration_Subnet
  depends_on                 = [module.VM-ApplicationTier]
}

module "DB-Backend" {
  source                       = "./modules/DB-Backend"
  resource_group_name          = var.resource_group_name
  location                     = var.location
  tier                         = var.tier
  backend_prefix               = var.backend_prefix
  sql_server_version           = var.sql_server_version
  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password
  create_mode                  = var.create_mode
  edition                      = var.edition
  subnet_id_internal           = module.VM-ApplicationTier.Internal_Subnet_Id
  depends_on                   = [module.BlobStorage]
}

module "BlobStorage" {
  source                           = "./modules/BlobStorage"
  resource_group_name              = var.resource_group_name
  location                         = var.location
  tier                             = var.tier
  storage_account_name             = var.storage_account_name
  storage_account_tier             = var.storage_account_tier
  storage_account_replication_type = var.storage_account_replication_type
  storage_container_name           = var.storage_container_name
  storage_container_access_type    = var.storage_container_access_type
  virtual_network_subnet_ids       = module.VM-ApplicationTier.Internal_Subnet_Id
  depends_on                       = [module.AppService-FrontEnd]
}