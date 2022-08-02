resource "azurerm_virtual_network" "meya_terraform" {
  count = var.VM_Service == "No" ? 0 : 1
  name                = "meya-network"
  resource_group_name = azurerm_resource_group.meya_terraform.name
  location            = azurerm_resource_group.meya_terraform.location
  address_space       = ["10.123.0.0/16"]

  tags = {
    environment = "dev"
  }
}
resource "azurerm_subnet" "meya_terraform" {
    count = var.VM_Service == "No" ? 0 : 1
    name                 = "meya-subnet"
    resource_group_name  = azurerm_resource_group.meya_terraform.name
    virtual_network_name = azurerm_virtual_network.meya_terraform[count.index].name
    address_prefixes     = ["10.123.1.0/24"]
}

resource "azurerm_network_security_group" "meya_terraform" {
    count = var.VM_Service == "No" ? 0 : 1
    name                = "meya-sg"
    location            = azurerm_resource_group.meya_terraform.location
    resource_group_name = azurerm_resource_group.meya_terraform.name

    tags = {
        environment = "dev"
  }
}

resource "azurerm_network_security_rule" "meya_terraform" {
    count = var.VM_Service == "No" ? 0 : 1
    name                        = "meya-dev-rule"
     priority                    = 100
     direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "*"
    source_port_range           = "*"
    destination_port_range      = "*"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
    resource_group_name         = azurerm_resource_group.meya_terraform.name
    network_security_group_name = azurerm_network_security_group.meya_terraform[count.index].name
}

resource "azurerm_subnet_network_security_group_association" "meya_terraform" {
    count = var.VM_Service == "No" ? 0 : 1
    subnet_id                 = azurerm_subnet.meya_terraform[count.index].id
    network_security_group_id = azurerm_network_security_group.meya_terraform[count.index].id
}

resource "azurerm_public_ip" "meya_terraform" {
    count = var.VM_Service == "No" ? 0 : 1
    name                = "meya-ip"
    resource_group_name = azurerm_resource_group.meya_terraform.name
    location            = azurerm_resource_group.meya_terraform.location
    allocation_method   = "Dynamic"

    tags = {
        environment = "dev"
  }
}

resource "azurerm_network_interface" "meya_terraform" {
    count = var.VM_Service == "No" ? 0 : 1
    name                = "meya-nic"
    location            = azurerm_network_security_group.meya_terraform[count.index].location
    resource_group_name = azurerm_resource_group.meya_terraform.name
    ip_configuration {
        name                          = "internal"
        subnet_id                     = azurerm_subnet.meya_terraform[count.index].id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.meya_terraform[count.index].id
    }
    tags = {
        environment = "dev"
  }

}

resource "azurerm_linux_virtual_machine" "meya_terraform" {
    count = var.VM_Service == "No" ? 0 : 1
    name                  = "meya-vm"
    resource_group_name   = azurerm_resource_group.meya_terraform.name
    location              = azurerm_resource_group.meya_terraform.location
    size                  = "Standard_F2"
    admin_username        = "adminuser"
    network_interface_ids = [azurerm_network_interface.meya_terraform[count.index].id]

    custom_data = filebase64("customdata.tpl")

    #admin_ssh_key {
    #    username   = "adminuser"
    #    public_key = file("~/.ssh/meyaazurekey.pub")
    #}

    os_disk {
        caching              = "ReadWrite"
            storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  provisioner "local-exec" {
    command = templatefile("windows-ssh-script.tpl", { hostname = self.public_ip_address,
    user = "adminuser",
    identityfile = "~/.ssh/meyaazurekey" })
    interpreter = ["Powershell", "Command"]
  }
  tags = {
    environment = "dev"
  }
}
