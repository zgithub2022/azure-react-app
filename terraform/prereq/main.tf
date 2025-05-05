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
  name                = "${var.container_registry}${random_id.suffix.hex}"
  resource_group_name = azurerm_resource_group.react_container_app_rg.name
  location            = azurerm_resource_group.react_container_app_rg.location
  sku                 = "Basic"
  admin_enabled       = true
}

resource "azurerm_management_lock" "resource-group-level" {
  name       = "resource-group-level"
  scope      = azurerm_resource_group.react_container_app_rg.id
  lock_level = "CanNotDelete"
  notes      = "This Resource Group can not be delete"
  depends_on = [azurerm_resource_group.react_container_app_rg]
}

resource "azurerm_management_lock" "resource-level" {
  name       = "resource-level"
  scope      = azurerm_container_registry.acr.id
  lock_level = "CanNotDelete"
  notes      = "This Container Registry can not be deleted"
  depends_on = [azurerm_container_registry.acr]
}

resource "null_resource" "docker_build" {
  provisioner "local-exec" {
  command = <<EOT
    docker build -t ${azurerm_container_registry.acr.login_server}/my-app-${var.environment}:latest --target ${var.environment} ../../.
    az acr login --name ${azurerm_container_registry.acr.name}
    docker push ${azurerm_container_registry.acr.login_server}/my-app-${var.environment}:latest
  EOT
  }
}
