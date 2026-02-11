# main.tf
data "azurerm_client_config" "current" {}

# Low-risk: Resource group only (no hourly services)
resource "azurerm_resource_group" "platform" {
  name     = "${var.prefix}-rg-platform"
  location = var.location
  tags     = var.default_tags
}

# -------------------------
# Policy 1: Require tags
# -------------------------
resource "azurerm_policy_definition" "require_tags" {
  name         = "${var.prefix}-require-tags"
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = "Require mandatory tags (Owner, Environment)"

  parameters = jsonencode({
    tagNames = {
      type         = "Array"
      metadata     = { displayName = "Mandatory tag names" }
      defaultValue = var.mandatory_tags
    }
  })

  # NOTE: This checks that both tags exist. For a scalable version, we'd loop, but this is beginner-simple.
  policy_rule = jsonencode({
    if = {
      anyOf = [
        { field = "[concat('tags[', parameters('tagNames')[0], ']')]", exists = "false" },
        { field = "[concat('tags[', parameters('tagNames')[1], ']')]", exists = "false" }
      ]
    }
    then = { effect = "deny" }
  })
}

resource "azurerm_subscription_policy_assignment" "require_tags" {
  name                 = "${var.prefix}-assign-require-tags"
  display_name         = "Enforce mandatory tags"
  subscription_id      = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
  policy_definition_id = azurerm_policy_definition.require_tags.id
}

# -------------------------
# Policy 2: Allowed locations
# -------------------------
resource "azurerm_policy_definition" "allowed_locations" {
  name         = "${var.prefix}-allowed-locations"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Restrict resource locations"

  parameters = jsonencode({
    allowedLocations = {
      type         = "Array"
      metadata     = { displayName = "Allowed locations" }
      defaultValue = var.allowed_locations
    }
  })

  policy_rule = jsonencode({
    if = {
      not = {
        field = "location"
        in    = "[parameters('allowedLocations')]"
      }
    }
    then = { effect = "deny" }
  })
}

resource "azurerm_subscription_policy_assignment" "allowed_locations" {
  name                 = "${var.prefix}-assign-allowed-locations"
  display_name         = "Allow only UK South/UK West"
  subscription_id      = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
  policy_definition_id = azurerm_policy_definition.allowed_locations.id
}
