terraform {
  required_version = ">= 1.2"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.26.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.7.2"
    }
  }
}

resource "random_id" "suffix" {
  byte_length = 8
}


resource "azurerm_user_assigned_identity" "webapp_id" {
  location            = var.location
  name                = "containerappmi-${var.environment}"
  resource_group_name = data.azurerm_resource_group.react_container_app_rg.name
  tags = {
    "environment" = var.environment
  }
}

resource "azurerm_role_assignment" "acr_pull" {
  scope                = data.azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_user_assigned_identity.webapp_id.principal_id
  depends_on = [
    azurerm_user_assigned_identity.webapp_id
  ]
}

resource "azurerm_service_plan" "react_container_app_sp" {
  name                = "react-container-app-sp-${random_id.suffix.hex}-${var.environment}"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.react_container_app_rg.name
  os_type             = "Linux"
  sku_name            = var.app_tier
  tags = {
    "environment" = var.environment
  }
}

resource "azurerm_linux_web_app" "react_container_app" {
  name                = "react-container-app-${random_id.suffix.hex}-${var.environment}"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.react_container_app_rg.name
  service_plan_id     = azurerm_service_plan.react_container_app_sp.id
  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.webapp_id.id]
  }

  app_settings = {
    WEBSITES_PORT = var.container_port
  }

  site_config {
    always_on                                     = false
    container_registry_use_managed_identity       = true
    container_registry_managed_identity_client_id = azurerm_user_assigned_identity.webapp_id.client_id
    # minimum_tls_version = 1.2
    application_stack {
      docker_image_name   = var.docker_image_name
      docker_registry_url = "https://${var.acr_login_url}"
    }
    ip_restriction_default_action = "Deny"

    dynamic "ip_restriction" {
      for_each = var.ip_address_list
      content {
        action     = "Allow"
        ip_address = ip_restriction.value
      }
    }
  }
  tags = {
    "environment" = var.environment
  }
}

data "azurerm_resource_group" "react_container_app_rg" {
  name = var.app_azurerm_rg
}

data "azurerm_container_registry" "acr" {
  name  = var.acr_name
  resource_group_name = var.app_azurerm_rg
}