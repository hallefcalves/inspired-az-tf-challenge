resource "azurerm_linux_virtual_machine_scale_set" "vmss" {
  name                = "vmss"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.vm_size
  instances           = 2
  admin_username      = "adminuser"
  admin_ssh_key {
    username   = "adminuser"
    public_key = var.ssh_key
  }

  disable_password_authentication = true

  zones = [1, 2, 3]

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  network_interface {
    name    = "example"
    primary = true
    ip_configuration {
      name                                   = "internal"
      primary                                = true
      subnet_id                              = var.subnet_id
      load_balancer_backend_address_pool_ids = var.load_balancer_backend_address_pool_ids
    }
    network_security_group_id = var.network_security_group_id
  }

  upgrade_mode = "Automatic"

  automatic_os_upgrade_policy {
    disable_automatic_rollback  = false
    enable_automatic_os_upgrade = true
  }

  health_probe_id = var.load_balancer_health_probe_id

  custom_data = base64encode(<<-EOF
    #!/bin/bash
    # Update package list and install Python, Pip, and Ansible
    apt-get update
    apt-get install -y python3 python3-pip
    pip3 install ansible

    # Create the Ansible playbook
    cat << 'EOP' > /home/adminuser/playbook.yaml
    ---
    - hosts: localhost
      become: yes
      tasks:
        - name: Update APT package manager
          apt:
            update_cache: yes

        - name: Install dependencies
          apt:
            name:
              - apt-transport-https
              - ca-certificates
              - curl
              - software-properties-common
            state: present

        - name: Add Docker's official GPG key
          apt_key:
            url: https://download.docker.com/linux/ubuntu/gpg
            state: present

        - name: Add Docker APT repository
          apt_repository:
            repo: "deb [arch=amd64] https://download.docker.com/linux/ubuntu {{ ansible_distribution_release }} stable"
            state: present

        - name: Install Docker
          apt:
            name: docker-ce
            state: present

        - name: Run NGINX container
          docker_container:
            name: nginx
            image: nginx:latest
            state: started
            ports:
              - "80:80"
    EOP

    # Run the Ansible playbook
    ansible-playbook /home/adminuser/playbook.yaml --connection=local
    EOF
  )

}