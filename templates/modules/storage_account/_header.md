# Azure Storage Account Module

This module creates an Azure Storage Account with configurable tiers, replication options, and security features. Based on Azure Verified Modules (AVM), it provides enterprise-grade cloud storage with support for blobs, files, queues, SFTP, and private endpoint connectivity.

## Usage

### Example - Basic Storage Account with Containers

```terraform
module "storage_account" {
  source = "./modules/storage_account"

  # Basic naming and location variables
  instance          = 1
  location          = "West Europe"
  stage             = "dev"
  product           = "dbk"
  short_description = "data"
  
  # Resource group
  resource_group_name = "rg-dbk-dev-westeurope-01"

  # Storage Account configuration
  storage_tier                      = "Standard"
  replication_type                  = "GRS"
  storage_access_tier               = "Hot"
  public_network_access_enabled     = false
  shared_access_key_enabled         = false
  allow_nested_items_to_be_public   = false
  default_to_oauth_authentication   = true
  allowed_copy_scope                = "AAD"

  # SFTP configuration
  sftp_enabled = true

  # Network firewall
  enable_firewall = true
  network_bypass = ["AzureServices"]
  allowed_ip_ranges = {
    "office"     = "203.0.113.0/24"
    "build-agent" = "198.51.100.1/32"
  }

  # Containers
  containers = {
    "documents" = {
      container_access_type = "private"
    }
    "backups" = {
      container_access_type = "private"
    }
    "logs" = {
      container_access_type = "private"
    }
  }

  # Queues
  queues = {
    "processing-queue" = {}
    "notifications"    = {}
  }

  # Role assignments
  roles = {
    "app-identity" = {
      role_definition_id_or_name = "Storage Blob Data Contributor"
      principal_id               = "12345678-1234-1234-1234-123456789012"
    }
    "backup-service" = {
      role_definition_id_or_name = "Storage Blob Data Reader"
      principal_id               = "87654321-4321-4321-4321-210987654321"
    }
  }

  # Private endpoints
  private_endpoints = {
    "blob" = {
      private_dns_zone_resource_id = "/subscriptions/sub-id/resourceGroups/rg-dns/providers/Microsoft.Network/privateDnsZones/privatelink.blob.core.windows.net"
      subnet_resource_id           = "/subscriptions/sub-id/resourceGroups/rg-network/providers/Microsoft.Network/virtualNetworks/vnet-main/subnets/snet-pe"
      subresource_name             = "blob"
      resource_group_name          = "rg-dbk-dev-westeurope-01"
    }
    "file" = {
      private_dns_zone_resource_id = "/subscriptions/sub-id/resourceGroups/rg-dns/providers/Microsoft.Network/privateDnsZones/privatelink.file.core.windows.net"
      subnet_resource_id           = "/subscriptions/sub-id/resourceGroups/rg-network/providers/Microsoft.Network/virtualNetworks/vnet-main/subnets/snet-pe"
      subresource_name             = "file"
      resource_group_name          = "rg-dbk-dev-westeurope-01"
    }
  }

  # Tags
  tags = {
    environment = "dbk-dev-westeurope"
    project     = "digital-transformation"
  }
}
```