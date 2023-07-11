resource "azurerm_network_security_group" "nsg" {
  name                = "${var.prefix}-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "${var.prefix}-rule"
    priority                   = var.priority
    direction                  = var.direction
    access                     = var.access
    protocol                   = var.protocol
    source_port_range          = var.source_port_range
    destination_port_range     = var.destination_port_range
    source_address_prefix      = var.source_address_prefix
    destination_address_prefix = var.destination_address_prefix
  }

  tags = {
    tier = var.tier
  }
}

resource "azurerm_virtual_network" "AppTier-Vnet" {
  name                = "${var.prefix}-AppTier-Vnet"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space

  tags = {
    tier = var.tier
  }
}

##Subnet is for AppService VNet Integration
resource "azurerm_subnet" "VNet-Integration-Subnet" {
  name                 = var.VNet_Integration_Subnet
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.AppTier-Vnet.name
  address_prefixes     = var.address_prefix_VNet_Integration
  service_endpoints    = var.service_endpoint_web
  delegation {
    name = "AppServiceDelegation"
    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

resource "azurerm_subnet" "Internal-Subnet" {
  name                 = "${var.prefix}-Internal-Subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.AppTier-Vnet.name
  address_prefixes     = var.address_prefix
  service_endpoints    = var.InternalSubnet_service_endpoints
}

resource "azurerm_subnet_network_security_group_association" "subnet_nsg" {
  subnet_id                 = azurerm_subnet.Internal-Subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_network_interface" "nic" {
  name                = "${var.prefix}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "${var.prefix}-AppTier"
    subnet_id                     = azurerm_subnet.Internal-Subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "vm" {
  name                  = "${var.prefix}-vm"
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.nic.id]
  vm_size               = var.vm_size

  delete_os_disk_on_termination = var.delete_os_disk_on_termination

  identity {
    type = "SystemAssigned"
  }
  storage_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.sku
    version   = var.image_version
  }
  storage_os_disk {
    name              = "${var.prefix}-os-disk"
    caching           = var.os_disk_caching
    create_option     = var.os_create_option
    managed_disk_type = var.os_disk_type
  }
  os_profile {
    computer_name  = var.vm_hostname
    admin_username = var.vm_admin_username
    admin_password = var.vm_admin_password
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    tier = var.tier
  }
}