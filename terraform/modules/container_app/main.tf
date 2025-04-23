resource "random_id" "suffix" {
  byte_length = 8
}


resource "azurerm_resource_group" "react_container_app_rg" {
  name                = "${var.azurerm_rg}-${var.environment}"
  location            = var.location
  tags = {
     "environment" = var.environment
  }
}

resource "azurerm_service_plan" "react_container_app_sp" {
  name                = "react-container-app-sp-${random_id.suffix.hex}-${var.environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.react_container_app_rg.name
  os_type  = "Linux"
  sku_name = var.app_tier
  tags = {
     "environment" = var.environment
  }
}

resource "azurerm_linux_web_app" "react_container_app" {
  name                       = "react-container-app-${random_id.suffix.hex}-${var.environment}"
  location                   = var.location
  resource_group_name        = azurerm_resource_group.react_container_app_rg.name
  service_plan_id            = azurerm_service_plan.react_container_app_sp.id
   app_settings = {
    WEBSITES_PORT = var.container_port
   }
  site_config {
    always_on = false
    # minimum_tls_version = 1.2
    application_stack {
      docker_image_name = var.docker_image_name
      docker_registry_url = var.acr_login_url
      docker_registry_username = var.acr_username
      docker_registry_password = var.acr_password
    }
    ip_restriction_default_action = "Deny" 

    dynamic "ip_restriction" {
       for_each = var.ip_address_list
       content {
        action = "Allow"
        ip_address  = ip_restriction.value
       }
    }
  }
  tags = {
     "environment" = var.environment
  }
}
