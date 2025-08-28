locals {
  subnets = {
    webapps = {
      cidr_range_size = 26
      idx = 0
      delegations = [
        {
          name    = "webapps_delegation"
          service = "Microsoft.Web/serverfarms"
        }
      ]
      nsg_rules = [
        {
          name     = "AllowHTTPS"
          protocol = "Tcp"
          source   = "VirtualNetwork"
          destination_port_ranges = ["443"]
        }
      ]
    }
    functions = {
      cidr_range_size = 26
      idx = 1
      delegations = [
        {
          name    = "webapps_delegation"
          service = "Microsoft.Web/serverfarms"
        }
      ]
      nsg_rules = [
        {
          name     = "AllowHTTPS"
          protocol = "Tcp"
          source   = "VirtualNetwork"
          destination_port_ranges = ["443"]
        }
      ]
    }
    pe = {
      cidr_range_size = 25
      idx = 3
      nsg_rules = []
    }
    database = {
      cidr_range_size = 27
      idx = 4
      nsg_rules = [
        {
          name        = "AllowSQL"
          protocol    = "Tcp"
          source      = "VirtualNetwork"
          destination = "VirtualNetwork"
          destination_port_ranges = ["1433"]
        }
      ]
    }
  }
}

module "network" {
  source = "../../modules/network"
  instance = var.instance
  location = var.location
  stage = var.stage
  product = var.product
  short_description = "vnet"
  address_space = var.vnet_address_space
  subnets = local.subnets
  tags = local.tags
}

module "private_dns_zones" {
  source  = "Azure/avm-ptn-network-private-link-private-dns-zones/azurerm"
  version = "0.16.0"
  location            = var.location
  resource_group_name = module.network.resource_group_name
  resource_group_creation_enabled = false
  private_link_private_dns_zones = {
    azure_app_service = {
      zone_name = "privatelink.azurewebsites.net"
    }
    azure_sql_server = {
      zone_name = "privatelink.database.windows.net"
    }
    azure_key_vault = {
      zone_name = "privatelink.vaultcore.azure.net"
    }
    azure_storage_blob: {
      "zone_name": "privatelink.blob.core.windows.net"
    }
  }
  virtual_network_resource_ids_to_link_to = {
    (module.network.vnet_name) = {
      vnet_resource_id = module.network.vnet_id
    }
  }
}