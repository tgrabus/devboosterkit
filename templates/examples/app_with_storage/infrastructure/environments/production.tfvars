location = "Poland Central"

stage = "production"

instance = 1

product = "dbk"

vnet_address_space = "10.0.10.0/22"

subnets_address_space = {
  webapps   = "10.0.10.0/26"
  functions = "10.0.10.64/26"
  pe        = "10.0.10.128/25"
  database  = "10.0.11.0/27"
}

sql_administrator_group = "devboosterkit"

public_network_access_enabled = false

allow_access_from_my_ip = false