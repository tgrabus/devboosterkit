locals {
  subnets = {
    webapps = {
      name            = "webapps"
      cidr_range_size = 26
      idx             = 0
      delegations = [
        {
          name    = "webapps_delegation"
          service = "Microsoft.Web/serverfarms"
        }
      ]
      nsg_rules = [
        {
          name                    = "AllowHTTPS"
          protocol                = "Tcp"
          source                  = "VirtualNetwork"
          destination_port_ranges = ["443"]
        }
      ]
    }
    functions = {
      name            = "functions"
      cidr_range_size = 26
      idx             = 1
      delegations = [
        {
          name    = "webapps_delegation"
          service = "Microsoft.Web/serverfarms"
        }
      ]
      nsg_rules = [
        {
          name                    = "AllowHTTPS"
          protocol                = "Tcp"
          source                  = "VirtualNetwork"
          destination_port_ranges = ["443"]
        }
      ]
    }
    pe = {
      name            = "pe"
      cidr_range_size = 25
      idx             = 3
      nsg_rules       = []
    }
    database = {
      name            = "database"
      cidr_range_size = 27
      idx             = 4
      nsg_rules = [
        {
          name                    = "AllowSQL"
          protocol                = "Tcp"
          source                  = "VirtualNetwork"
          destination             = "VirtualNetwork"
          destination_port_ranges = ["1433"]
        }
      ]
    }
  }
}

module "vnet" {
  source            = "../../modules/network"
  instance          = var.instance
  location          = var.location
  stage             = var.stage
  product           = var.product
  short_description = "vnet"
  address_space     = var.vnet_address_space
  subnets           = local.subnets
  tags              = local.tags
}