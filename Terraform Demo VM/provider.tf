provider "azurerm" {
  subscription_id = "${var.service_subscription_id}"
  client_id       = "${var.service_principal_client_id}"
  client_secret   = "${var.service_principal_client_secret}"
  tenant_id       = "${var.service_tenant_id}"
}
