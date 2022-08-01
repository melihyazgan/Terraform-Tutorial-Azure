variable "location" {
  type    = string
  default = "westeurope"
}

variable "rsgname" {
  type        = string
  description = "Resource Group name"
  default     = "Terraformrsg_meya"
}

variable "ARM_CLIENT_ID" {
  type    = string
  default = ""
}

variable "ARM_CLIENT_SECRET" {
  type    = string
  default = ""
}

variable "ARM_SUBSCRIPTION_ID" {
  type    = string
  default = ""
}

variable "ARM_TENANT_ID" {
  type    = string
  default = ""
}

variable "ML_Service" {
  type = string
  default = "No"
  description = "No: Don't Create ML Service Resource"
}

output "resource_group_id" {
  value = azurerm_resource_group.meya_terraform.id
}
