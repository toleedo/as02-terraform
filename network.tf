resource "azurerm_virtual_network" "as02-network" {
    name                = "vnet"
    location            = azurerm_resource_group.as02-atividade.location
    resource_group_name = azurerm_resource_group.as02-atividade.name
    address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "atividade02-subnet" {
    name                 = "vsubnet"
    resource_group_name  = azurerm_resource_group.as02-atividade.name
    virtual_network_name = azurerm_virtual_network.as02-network.name
    address_prefixes       = ["10.0.1.0/24"]
}

resource "azurerm_network_security_group" "as02-nsg" {
    name                = "networksecuritygroup"
    location            = azurerm_resource_group.as02-atividade.location
    resource_group_name = azurerm_resource_group.as02-atividade.name

    security_rule {
        name                       = "mysql"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "3306"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    security_rule {
        name                       = "SSH"
        priority                   = 1002
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }
}

resource "azurerm_public_ip" "as02-publicip" {
    name                         = "ippublic"
    location                     = azurerm_resource_group.as02-atividade.location
    resource_group_name          = azurerm_resource_group.as02-atividade.name
    allocation_method            = "Static"
}

resource "azurerm_network_interface" "as02-nic" {
    name                      = "networkinterface"
    location                  = azurerm_resource_group.as02-atividade.location
    resource_group_name       = azurerm_resource_group.as02-atividade.name

    ip_configuration {
        name                          = "ipvm"
        subnet_id                     = azurerm_subnet.as02-subnet.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.as02-publicip.id
    }
}

resource "azurerm_network_interface_security_group_association" "as02-nsg" {
    network_interface_id      = azurerm_network_interface.as02-nic.id
    network_security_group_id = azurerm_network_security_group.as02-nsg.id
}