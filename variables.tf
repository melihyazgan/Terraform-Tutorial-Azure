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
  default = "wEn8Q~FsybsJ2~FLJB6-Bk6B0jm95sI5yfVz7bUQ"
}

variable "ARM_SUBSCRIPTION_ID" {
  type    = string
  default = "ffd96b6f-1fcb-4bb8-b0ad-b151d795064a"
}

variable "ARM_TENANT_ID" {
  type    = string
  default = "0ae51e19-07c8-4e4b-bb6d-648ee58410f4"
}

