terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id   = "17abc602-7315-4600-a8f8-412c409d1d92"
  client_id         = "d73508a9-e551-45f0-8bf1-9d7114f7b8b9"
  client_secret     = "-_L8Q~c--XuMWToFrbK51GrWdC6DOddH69oDjaL6"
  tenant_id         = "10f1e709-440c-4a18-9025-699d00a15b85"
}

# Creating Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "my-resource-group"
  location = "East US"
}

# Creating Storage Account (Make sure the name is unique)
resource "azurerm_storage_account" "storage" {
  name                     = "mystorageacc218"  # Must be globally unique
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  # Required for blob storage support
  #allow_blob_public_access = false  
}

# Creating Storage Container (Now 100% Fixed)
resource "azurerm_storage_container" "container" {
  name                  = "mycontainer517"
  storage_account_name  = azurerm_storage_account.storage.name  # ✅ FIXED (Use 'name' instead of 'id')
  container_access_type = "private"
}

# Output Values
output "storage_account_name" {
  value = azurerm_storage_account.storage.name
}

output "container_name" {
  value = azurerm_storage_container.container.name
}

output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}
