resource "azurerm_linux_virtual_machine" "as02-vm" {
    name                  = "virtualmachine"
    location              = azurerm_resource_group.as02-atividade.location
    resource_group_name   = azurerm_resource_group.as02-atividade.name
    size                  = "Standard_DS1_v2"
    admin_username        = "gtoledo"
    admin_password        = "Mudar@2021"
    disable_password_authentication = false
    
    network_interface_ids = [azurerm_network_interface.as02-nic.id]
    
    os_disk {
        name              = "diskSO"
        caching           = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    source_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
    }
}