terraform {
  required_version = ">= 1.2"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.26.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "react-rg"
    storage_account_name = "reactapptwentyfourapr"
    container_name       = "tfstate"
    key                  = "path/to/my/terraform.tfstate"
  }
}

provider "azurerm" {
  # Configuration options
  features {}
  subscription_id = var.subscription_id
}
