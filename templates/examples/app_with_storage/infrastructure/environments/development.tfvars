location = "Poland Central"

stage = "development"

instance = 1

product = "dbk"

vnet_address_space = "10.0.8.0/22"

subnets_address_space = {
  webapps   = "10.0.8.0/26"
  functions = "10.0.8.64/26"
  pe        = "10.0.8.128/25"
  database  = "10.0.9.0/27"
}

sql_administrator_group = "devboosterkit"

public_network_access_enabled = true

allow_access_from_my_ip = true

email_receivers = {
  "example" = "example@gmail.com"
}

purge_protection_enabled = false