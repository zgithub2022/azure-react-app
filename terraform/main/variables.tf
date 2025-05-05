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

variable "container_registry" {
  description = "Name of container registry"
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