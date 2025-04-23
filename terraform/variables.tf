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

variable "acr_login_url" {
  description = "The url for Azure Container Registry"
  type        = string
}

variable "docker_image_name" {
  description = "The name of docker image including tag"
  type        = string
}

variable "acr_username" {
  description = "The tag of docker image"
  type        = string
  default     = "latest"
}

variable "acr_password" {
  description = "The tag of docker image"
  type        = string
  default     = "latest"
  sensitive   = true
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