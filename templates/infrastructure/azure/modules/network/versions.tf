terraform {
  required_version = ">= 1.4.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.0"
    }

    random = {
      source  = "hashicorp/random"
      version = ">= 3.3.2"
    }

    azurecaf = {
      source  = "aztfmod/azurecaf"
      version = ">= 1.2.28"
    }

    azapi = {
      source  = "azure/azapi"
      version = ">=2.0, <3.0"
    }
  }
}
