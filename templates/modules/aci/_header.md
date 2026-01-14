# Azure Container Instances Module

This module creates Azure Container Instances (ACI) with standardized naming conventions and security best practices. Based on Azure Verified Modules (AVM), it provides serverless container deployment capabilities with managed identity integration and virtual network support.

## Usage

### Example - Container Instance
```terraform
module "aci" {
  source = "./modules/aci"

  # Basic naming and location variables
  instance          = 1
  location          = "West Europe"
  stage             = "dev"
  product           = "dbk"
  short_description = "main"

  # Resource group
  resource_group_name = "rg-dbk-dev-westeurope-01"

  # Container configuration
  containers = {
    "app" = {
      server     = "myregistry.azurecr.io"
      image_name = "myapp"
      image_tag  = "latest"
      cpu        = 2
      memory     = 8
      ports = [
        {
          port     = "80"
          protocol = "TCP"
        }
      ]
    }
  }

  # Network configuration
  subnet_id = "/subscriptions/sub-id/resourceGroups/rg-network/providers/Microsoft.Network/virtualNetworks/vnet-main/subnets/snet-aci"

  # Availability zones
  zones = ["1", "2"]

  # Environment variables
  environment_vars = {
    "ENVIRONMENT" = "dev"
    "REGION"      = "westeurope"
  }

  # Secure environment variables (for sensitive data)
  secure_environment_vars = {
    "API_KEY" = "sensitive-value"
  }

  # Tags
  tags = {
    environment = "dbk-dev-westeurope"
    project     = "digital-transformation"
  }
}
```
