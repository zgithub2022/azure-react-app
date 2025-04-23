terraform {
  required_version = ">= 1.2"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.26.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.0.0"
    }
  }
  backend "azurerm" {
      resource_group_name  = "react-rg"
      storage_account_name = "reactapptwentythreeapr"
      container_name       = "tfstate"
      key                  = "path/to/my/terraform.tfstate"
  }
}

provider "azurerm" {
  # Configuration options
  features {}
  subscription_id = "8c11bf93-bc1d-4db6-b668-158dd1e8072c"
  # resource_provider_registrations = "none"
}
