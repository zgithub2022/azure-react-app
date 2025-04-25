module "contaier_app" {
  source            = "./modules/container_app"
  environment = var.environment
  azurerm_rg        = var.azurerm_rg
  location          = var.location
  acr_login_url     = var.acr_login_url
  docker_image_name = var.docker_image_name
  acr_name          = var.acr_name
  app_tier          = var.app_tier
  ip_address_list   = var.ip_address_list
  container_port    = var.container_port
  registrylocation  = var.registrylocation
}
