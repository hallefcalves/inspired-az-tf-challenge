resource "azurerm_virtual_network" "main" {
  name                = "vnet"
  address_space       = [var.vnet_cidr]
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "subnets" {
  count               = length(var.subnet_cidrs)
  name                = "subnet-${count.index}"
  resource_group_name = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes    = [var.subnet_cidrs[count.index]]
}
