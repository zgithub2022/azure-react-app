output "azurerm_container_registry_name" {
  value = azurerm_container_registry.acr.name
}

output "azurerm_resource_group_name" {
  value = azurerm_resource_group.react_container_app_rg.name
}

output "acr_admin_username" {
  value     = azurerm_container_registry.acr.admin_username
  sensitive = true
}

output "acr_admin_password" {
  value     = azurerm_container_registry.acr.admin_password
  sensitive = true
}