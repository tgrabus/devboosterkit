module "this" {
  source             = "Azure/avm-res-network-privateendpoint/azurerm"
  version = "0.2.0"
  name                           = module.pe_naming.result
  location = var.location
  resource_group_name            = var.resource_group_name
  network_interface_name         = module.nic_naming.result
  private_service_connection_name = module.pe_naming.result
  private_connection_resource_id = var.private_connection_resource_id
  private_dns_zone_resource_ids = [var.private_dns_zone_resource_id]
  subnet_resource_id             = var.subnet_resource_id
  subresource_names              = [var.subresource_name]
}