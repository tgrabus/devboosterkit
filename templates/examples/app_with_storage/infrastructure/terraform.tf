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
      version = "~>1.2.28"
    }

    azapi = {
      source  = "azure/azapi"
      version = "~>2.0"
    }
  }
}

provider "azurerm" {
  subscription_id = lookup(var.subscription_ids, var.stage)
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
    key_vault {
      purge_soft_delete_on_destroy = false
    }
  }
  storage_use_azuread = true
}
