resource "azurerm_linux_virtual_machine_scale_set" "vmss" {
  name                = "vmss"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.vm_size

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "22.04-LTS"
    version   = "latest"
  }

  upgrade_policy {
    mode = "Automatic"
  }

  os_profile {
    admin_username = "adminuser"
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/adminuser/.ssh/authorized_keys"
      key_data = var.ssh_key
    }
  }

  admin_username = "adminuser"

  network_profile {
    name    = "network-profile"
    primary = true
    ip_configuration {
      name      = "internal"
      subnet_id = var.subnet_id
    }
  }

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.boot_diag.primary_blob_endpoint
  }
}
