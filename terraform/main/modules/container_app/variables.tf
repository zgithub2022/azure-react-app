variable "app_azurerm_rg" {
  description = "The name for the Azure resource group."
  type        = string
}

variable "environment" {
  description = "Environment for the app"
  type        = string
  default     = "dev"
}

variable "location" {
  description = "The location for Azure resources."
  type        = string
  default     = "West Europe"
}

variable "docker_image_name" {
  description = "The name of docker image including tag"
  type        = string
}

variable "acr_login_url" {
  description = "docker registry login"
  type        = string
}

variable "acr_name" {
  description = "container registry name"
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

variable "container_registry_rg" {
  description = "container registry resource group"
  type        = string
}