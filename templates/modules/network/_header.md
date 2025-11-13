# Azure Network Module

This module creates a comprehensive Azure Virtual Network (VNet) infrastructure with subnets, network security groups (NSGs), 
and route tables. The module provides a standardized approach to network segmentation and security for Azure workloads.

The module leverages Azure Verified Modules (AVM) to ensure best practices and provides configurable subnet definitions, 
NSG rules, and network routing capabilities for enterprise-grade network architecture.

## Features

This module provides network infrastructure functionality with the following capabilities:

- Creates Virtual Network with standardized naming conventions
- Configurable address space and subnet definitions
- Network Security Groups (NSGs) with customizable rules
- Route tables for custom routing scenarios
- VM protection enabled by default
- Support for multiple subnets with different configurations
- Integration with Azure services delegation

## Usage

To use this module in your Terraform configuration, you'll need to provide values for the required variables.

### Example - Basic Virtual Network with Subnets

This example shows the most basic usage of the module for creating a virtual network with multiple subnets.
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