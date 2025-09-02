locals {

  tags = {
    environment = "${var.stage}_${var.location}_${var.instance}"
    product     = var.product
    managedBy   = "Terraform"
    version     = "1.0.0"
  }
}