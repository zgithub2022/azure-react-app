module "contaier_app" {
  source               = "./modules/container_app"
  environment          = var.environment
  container_azurerm_rg = var.container_azurerm_rg
  app_azurerm_rg       = var.app_azurerm_rg
  location             = var.location
  docker_image_name    = var.docker_image_name
  acr_name             = var.acr_name
  app_tier             = var.app_tier
  ip_address_list      = var.ip_address_list
  container_port       = var.container_port
}
