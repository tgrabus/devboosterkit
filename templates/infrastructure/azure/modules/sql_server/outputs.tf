output "sql_server" {
  value = {
    name = module.server.resource.name
    fqdn = module.server.resource.fully_qualified_domain_name
  }
}

output "databases" {
  value = {
    for key, db in module.databases : key => {
      name        = db.name
      conn_string = "Server=tcp:${module.server.resource.fully_qualified_domain_name},1433;Initial Catalog=${db.name};Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;Authentication=\"Active Directory Default\";"
    }
  }
}