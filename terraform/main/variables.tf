variable "app_azurerm_rg" {
  description = "The name for the Azure resource group."
  type        = string
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

variable "docker_image_name" {
  description = "The name of docker image including tag"
  type        = string
}

variable "acr_name" {
  description = "Container Registry Name"
  type        = string
}

variable "app_tier" {
  description = "The tier of app"
  type        = string
  default     = "F1"
}

variable "ip_address_list" {
  description = "Allowed ip address for app"
  type        = list(string)
}

variable "container_port" {
  description = "container port"
  type        = number
}

variable "subscription_id" {
  description = "azure subscription"
  type        = string
}