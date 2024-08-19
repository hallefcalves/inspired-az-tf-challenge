resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

module "vnet" {
  source              = "./modules/vnet"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  vnet_cidr           = var.vnet_cidr
  subnet_cidrs        = var.subnet_cidrs
}

module "nsg" {
  source              = "./modules/nsg"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}

module "alb" {
  source              = "./modules/alb"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}

module "vmss" {
  source                    = "./modules/vmss"
  resource_group_name       = azurerm_resource_group.rg.name
  location                  = azurerm_resource_group.rg.location
  vm_size                   = var.vm_size
  subnet_id                 = element(module.vnet.subnet_ids, 0)
  ssh_key                   = var.ssh_key
  network_security_group_id = module.nsg.network_security_group_id

  load_balancer_backend_address_pool_ids = module.alb.lb_backend_pool_id
  load_balancer_health_probe_id          = module.alb.load_balancer_health_probe_id
  depends_on                             = [module.alb, module.nsg, module.vnet]
}