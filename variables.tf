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
  default = "e0a0b9a6-7559-48a1-b1cc-e7567b84f02e"
}

variable "ARM_CLIENT_SECRET" {
  type    = string
  default = "zwm8Q~YwOCw0csna5PUBf20zhR7LEeRRwLKWIauw"
}

variable "ARM_SUBSCRIPTION_ID" {
  type    = string
  default = "ffd96b6f-1fcb-4bb8-b0ad-b151d795064a"
}

variable "ARM_TENANT_ID" {
  type    = string
  default = "0ae51e19-07c8-4e4b-bb6d-648ee58410f4"
}

variable "ML_Service" {
  type = string
  default = "No"
  description = "No: Don't Create ML Service Resource"
}
