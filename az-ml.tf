# Acoording to Doku associated resources are:
# - Azure Storage Account
# - Azure Application Insights
# - Azure Key Vault

resource "azurerm_storage_account" "meya_terraform" {
  count = var.ML_Service == "No" ? 0 : 1
  name                     = "meyastgeaccount"
  resource_group_name      = azurerm_resource_group.meya_terraform.name
  location                 = azurerm_resource_group.meya_terraform.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}
resource "azurerm_application_insights" "meya_terraform" {
  count = var.ML_Service == "No" ? 0 : 1
  name                = "meyaappinsights"
  location            = azurerm_resource_group.meya_terraform.location
  resource_group_name = azurerm_resource_group.meya_terraform.name
  application_type    = "web"
}
resource "azurerm_key_vault" "meya_terraform" {
  count = var.ML_Service == "No" ? 0 : 1
  name                        = "meyakeyvault"
  location                    = azurerm_resource_group.meya_terraform.location
  resource_group_name         = azurerm_resource_group.meya_terraform.name
  enabled_for_disk_encryption = true
  tenant_id                   = var.ARM_TENANT_ID
  sku_name                    = "standard"
}