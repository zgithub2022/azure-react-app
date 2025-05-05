output "azurerm_container_app_url" {
  value = azurerm_linux_web_app.react_container_app.default_hostname
}