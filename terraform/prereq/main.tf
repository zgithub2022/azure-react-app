resource "azurerm_resource_group" "react_container_app_rg" {
  name     = "react-rg-${var.environment}"
  location = var.location
  tags = {
    "environment" = var.environment
  }
}

resource "azurerm_container_registry" "acr" {
  name                = var.container_registry
  resource_group_name = azurerm_resource_group.react_container_app_rg.name
  location            = azurerm_resource_group.react_container_app_rg.location
  sku                 = "Basic"
  admin_enabled       = false
}

resource "azurerm_management_lock" "resource-group-level" {
  name       = "resource-group-level"
  scope      = azurerm_resource_group.react_container_app_rg.name
  lock_level = "CanNotDelete"
  notes      = "This Resource Group can not be delete"
}