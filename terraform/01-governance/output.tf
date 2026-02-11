# outputs.tf
output "subscription_id" {
  value = data.azurerm_client_config.current.subscription_id
}

output "platform_rg" {
  value = azurerm_resource_group.platform.name
}

output "policy_assignments" {
  value = {
    require_tags      = azurerm_subscription_policy_assignment.require_tags.name
    allowed_locations = azurerm_subscription_policy_assignment.allowed_locations.name
  }
}
