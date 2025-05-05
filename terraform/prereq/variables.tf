variable "azurerm_rg" {
  description = "The name for the Azure resource group."
  type        = string
  default     = "appc-react-np-rg"
}

variable "location" {
  description = "The location for Azure resources."
  type        = string
  default     = "West US"
}

variable "environment" {
  description = "Environment for the app"
  type        = string
  default     = "dev"
}

variable "subscription_id" {
  description = "azure subscription"
  type        = string
}

variable "azurerm_rg" {
  description = "azure resource group"
  type        = string
}

variable "container_registry" {
  description = "container registry name"
  type        = string
}