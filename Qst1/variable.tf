##Azure-Login-Details##

variable "client_secret" {}

variable "client_id" {}

variable "tenant_id" {}

variable "subscription_id" {}

## common ##

variable "resource_group_name" {}

variable "location" {}

variable "tier" {}

##App-Service-Plan##

variable "asp_name" {}

variable "os_type" {}

variable "sku_name" {}

##App-Service##

variable "AppService_name" {}

variable "node_version" {}

##VM##

variable "prefix" {}

variable "address_space" {}

variable "address_prefix" {}

variable "vm_size" {}

variable "delete_os_disk_on_termination" {}

variable "publisher" {}

variable "offer" {}

variable "sku" {}

variable "image_version" {}

variable "os_disk_caching" {}

variable "os_create_option" {}

variable "os_disk_type" {}

variable "vm_hostname" {}

variable "vm_admin_username" {}

variable "vm_admin_password" {}

variable "priority" {}

variable "direction" {}

variable "access" {}

variable "protocol" {}

variable "source_port_range" {}

variable "destination_port_range" {}

variable "source_address_prefix" {}

variable "destination_address_prefix" {}

variable "InternalSubnet_service_endpoints" {}

variable "VNet_Integration_Subnet" {}

variable "address_prefix_VNet_Integration" {}

variable "service_endpoint_web" {}

## Azure SQL Backend ##

variable "backend_prefix" {}

variable "sql_server_version" {}

variable "administrator_login" {}

variable "administrator_login_password" {}

variable "create_mode" {}

variable "edition" {}

## Azure Blob Storage ##

variable "storage_account_name" {}

variable "storage_account_tier" {}

variable "storage_account_replication_type" {}

variable "storage_container_name" {}

variable "storage_container_access_type" {}