variable "resource_group_name" {
  type        = "string"
  description = "Name of the azure resource group."
}

variable "resource_group_location" {
  type        = "string"
  description = "Location of the azure resource group."
}

variable "service_subscription_id" {
  type = "string"
}

variable "service_principal_client_id" {
  type        = "string"
  description = "The client id of the azure service principal used by Kubernetes to interact with Azure APIs."
}

#Note: All arguments including the client secret will be stored in the raw state as plain-text. Read more about sensitive data in state at https://www.terraform.io/docs/providers/azurerm/r/container_service.html
variable "service_principal_client_secret" {
  type        = "string"
  description = "The client secret of the azure service principal used by Kubernetes to interact with Azure APIs."
}

variable "service_tenant_id" {
  type = "string"
}
