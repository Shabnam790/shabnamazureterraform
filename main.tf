terraform{
    required_providers{
        azurerm={
            source="hashicorp/azurerm"
            version="2.98.0"
        }
    }
}
provider "azurerm"{
    features{}
}


resource "azurerm_resource_group" "rg_shabnam_dev"{
    name=var.dev_var
    location="central india"
}

resource "azurerm_resource_group" "rg_Shabnam_qa" {
  name     = var.qa_var
  location = "Central India"
}

resource "azurerm_app_service_plan" "dev_plan_appservice" {
  name                = "dev_plan_appservice"
  location            = azurerm_resource_group.rg_shabnam_dev.location
  resource_group_name = azurerm_resource_group.rg_shabnam_dev.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service_plan" "qa_plan_appservice" {
  name                = "qa_plan_appservice"
  location            = azurerm_resource_group.rg_Shabnam_qa.location
  resource_group_name = azurerm_resource_group.rg_Shabnam_qa.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "dev-shabnam-appservice" {
  name                = "dev-shabnam-appservice"
  location            = azurerm_resource_group.rg_shabnam_dev.location
  resource_group_name = azurerm_resource_group.rg_shabnam_dev.name
  app_service_plan_id = azurerm_app_service_plan.dev_plan_appservice.id

}

resource "azurerm_app_service" "qa-Shabnam-appservice" {
  name                = "qa-Shabnam-appservicee"
  location            = azurerm_resource_group.rg_Shabnam_qa.location
  resource_group_name = azurerm_resource_group.rg_Shabnam_qa.name
  app_service_plan_id = azurerm_app_service_plan.qa_plan_appservice.id

}

resource "azurerm_storage_account" "sabnamdevstorageaccount" {
  name                     = "sabnamdevstorageaccount"
  resource_group_name      = azurerm_resource_group.rg_shabnam_dev.name
  location                 = azurerm_resource_group.rg_shabnam_dev.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

resource "azurerm_storage_account" "sabnamqastorageaccount" {
  name                     = "sabnamqastorageaccount"
  resource_group_name      = azurerm_resource_group.rg_Shabnam_qa.name
  location                 = azurerm_resource_group.rg_Shabnam_qa.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}
