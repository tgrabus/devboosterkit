locals {
  tags = {
    product   = var.product
    stage     = var.stage
    location  = var.location
    instance  = var.instance
    managedBy = "Terraform"
    ownedBy   = "Platform"
    version   = "1.0.0"
  }
}