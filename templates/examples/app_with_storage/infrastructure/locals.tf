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

  allowed_ips = (var.allow_access_from_my_ip ?
    {
      my_ip = format("%s/32", data.http.ip[0].response_body)
  } : {})
}