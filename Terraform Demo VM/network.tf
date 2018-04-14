# Create a virtual network within the resource group
########################################################
resource "azurerm_virtual_network" "net_test" {
  name                = "bootcamp-network"
  address_space       = ["10.0.0.0/8"]
  location            = "${azurerm_resource_group.rg.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
}

resource "azurerm_subnet" "subnet_test" {
  name                 = "subnet_test"
  resource_group_name  = "${azurerm_resource_group.rg.name}"
  virtual_network_name = "${azurerm_virtual_network.net_test.name}"
  address_prefix       = "10.0.1.0/24"
}

resource "azurerm_public_ip" "pub_ip_test" {
  name                         = "ubt-pip-test"
  location                     = "${azurerm_resource_group.rg.location}"
  resource_group_name          = "${azurerm_resource_group.rg.name}"
  public_ip_address_allocation = "Dynamic"
  idle_timeout_in_minutes      = 30

  tags {
    environment = "test"
  }
}

# Netwrok Security Group Definition
########################################################################
resource "azurerm_network_security_group" "test_nsg" {
  name                = "testNsg"
  location            = "${azurerm_resource_group.rg.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"

  security_rule {
    name                       = "TestSSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags {
    environment = "test"
  }
}


