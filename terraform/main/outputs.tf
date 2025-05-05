output "azurerm_container_registry_name" {
  value = azurerm_container_registry.acr.name
}

output "azurerm_resource_group_name" {
  value = azurerm_resource_group.react_container_app_rg.name
}

output "azurerm_container_app_url" {
  value = module.contaier_app.azurerm_container_app_url
}