# Create a vm for test
#######################################################################################

resource "azurerm_network_interface" "net_int_test" {
  name                      = "net_int_test"
  location                  = "${azurerm_resource_group.rg.location}"
  resource_group_name       = "${azurerm_resource_group.rg.name}"
  network_security_group_id = "${azurerm_network_security_group.test_nsg.id}"

  ip_configuration {
    name                          = "net_test_ipconf"
    subnet_id                     = "${azurerm_subnet.subnet_test.id}"
    private_ip_address_allocation = "dynamic"
    public_ip_address_id          = "${azurerm_public_ip.pub_ip_test.id}"
  }
}

resource "azurerm_storage_account" "test_stor" {
  name                     = "jjgteststor01"
  resource_group_name      = "${azurerm_resource_group.rg.name}"
  location                 = "${azurerm_resource_group.rg.location}"
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags {
    environment = "testing"
  }
}

resource "azurerm_storage_container" "test_stor_container" {
  name                  = "vhds"
  resource_group_name   = "${azurerm_resource_group.rg.name}"
  storage_account_name  = "${azurerm_storage_account.test_stor.name}"
  container_access_type = "private"
}

resource "azurerm_virtual_machine" "test_vm" {
  name                  = "azvmtest01"
  location              = "${azurerm_resource_group.rg.location}"
  resource_group_name   = "${azurerm_resource_group.rg.name}"
  network_interface_ids = ["${azurerm_network_interface.net_int_test.id}"]
  vm_size               = "Basic_A0"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  # delete_os_disk_on_termination = true


  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name          = "testosdisk01"
    vhd_uri       = "${azurerm_storage_account.test_stor.primary_blob_endpoint}${azurerm_storage_container.test_stor_container.name}/testosdisk01.vhd"
    caching       = "ReadWrite"                                                                                                                        //
    create_option = "FromImage"
  }

  # Optional data disks
  # storage_data_disk {
  #   name          = "datadisk0"
  #   vhd_uri       = "${azurerm_storage_account.test.primary_blob_endpoint}${azurerm_storage_container.test.name}/datadisk0.vhd"
  #   disk_size_gb  = "1023"
  #   create_option = "Empty"
  #   lun           = 0
  # }

  os_profile {
    computer_name  = "aztest01"
    admin_username = "gazzolaj"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags {
    environment = "testing"
  }
}
