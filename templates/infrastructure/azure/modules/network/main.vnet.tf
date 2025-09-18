# Create Virtual Network
module "vnet" {
  source               = "Azure/avm-res-network-virtualnetwork/azurerm"
  version              = "0.10.0"
  resource_group_name  = var.resource_group_name
  location             = var.location
  name                 = module.vnet_naming.result
  address_space        = [var.address_space]
  enable_vm_protection = true
  tags                 = var.tags
}