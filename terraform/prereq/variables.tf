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

variable "app_azurerm_rg" {
  description = "azure resource group"
  type        = string
}
