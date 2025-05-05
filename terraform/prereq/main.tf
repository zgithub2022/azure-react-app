resource "random_id" "suffix" {
  byte_length = 8
}


resource "azurerm_resource_group" "react_container_app_rg" {
  name     = "${var.azurerm_rg}-${var.environment}"
  location = var.location
  tags = {
    "environment" = var.environment
  }
}

