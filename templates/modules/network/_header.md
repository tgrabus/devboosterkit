# Azure Network Module

This module creates an Azure Virtual Network infrastructure with subnets, network security groups, and route tables. Based on Azure Verified Modules (AVM), it provides enterprise-grade network segmentation and security for Azure workloads.

## Usage

To use this module in your Terraform configuration, you'll need to provide values for the required variables.

### Example - Virtual Network with Subnets

```terraform
module "network" {
  source = "./modules/network"

  # Basic naming and location variables
  instance          = 1
  location          = "West Europe"
  stage             = "dev"
  product           = "dbk"
  short_description = "main"
  
  # Resource group
  resource_group_name = "rg-dbk-dev-westeurope-01"

  # Network configuration
  address_space = "10.0.0.0/16"

  # Subnets configuration
  subnets = {
    web = {
      cidr_range_size = 24
      idx             = 1
      nsg_rules = [
        {
          name                    = "AllowHTTP"
          protocol                = "Tcp"
          source                  = "Internet"
          destination_port_ranges = ["80"]
        },
        {
          name                    = "AllowHTTPS"
          protocol                = "Tcp"
          source                  = "Internet"
          destination_port_ranges = ["443"]
        }
      ]
      delegations = [
        {
          name    = "webapp-delegation"
          service = "Microsoft.Web/serverFarms"
        }
      ]
    }
    
    app = {
      cidr_range_size = 24
      idx             = 2
      nsg_rules = [
        {
          name                    = "AllowFromWeb"
          protocol                = "Tcp"
          source                  = "10.0.1.0/24"
          destination_port_ranges = ["8080", "8443"]
        }
      ]
      delegations = []
    }
    
    data = {
      cidr_range_size = 24
      idx             = 3
      nsg_rules = [
        {
          name                    = "AllowFromApp"
          protocol                = "Tcp"
          source                  = "10.0.2.0/24"
          destination_port_ranges = ["1433", "5432"]
        }
      ]
      delegations = []
    }
  }

  # Tags
  tags = {
    environment = "dbk-dev-westeurope"
    project     = "digital-transformation"
  }
}
```