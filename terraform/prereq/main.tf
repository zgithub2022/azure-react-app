resource "random_id" "suffix" {
  byte_length = 8
}


resource "azurerm_resource_group" "react_container_app_rg" {
  name     = "react-rg-${var.environment}"
  location = var.location
  tags = {
    "environment" = var.environment
  }
}

resource "azurerm_container_registry" "acr" {
  name                = var.app_azurerm_rg
  resource_group_name = azurerm_resource_group.react_container_app_rg.name
  location            = azurerm_resource_group.react_container_app_rg.location
  sku                 = "Basic"
  admin_enabled       = false
}
