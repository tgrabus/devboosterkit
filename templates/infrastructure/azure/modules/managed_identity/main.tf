# Create User Assigned Managed Identity
resource "azurerm_user_assigned_identity" "this" {
  name                = module.naming.result
  location            = var.location
  resource_group_name = var.resource_group_name
}

# Assign roles
resource "azurerm_role_assignment" "this" {
  for_each             = var.roles
  scope                = each.value.scope
  role_definition_name = each.value.role_name
  principal_id         = azurerm_user_assigned_identity.this.principal_id
}