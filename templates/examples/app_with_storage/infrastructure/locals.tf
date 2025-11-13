locals {
  tags = {
    environment = "${var.product}_${var.stage}_${var.location}_${var.instance}"
    product     = var.product
    stage       = var.stage
    location    = var.location
    instance    = var.instance
    managedBy   = "Terraform"
    version     = "1.0.0"
  }
}