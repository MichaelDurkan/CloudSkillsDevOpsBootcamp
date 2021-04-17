provider "azurerm" {
    features {}
}

resource "azurerm_app_service_plan" "mdcs-azsp" {
    name                   = var.app_service_plan_name
    location               = var.location
    resource_group_name    = var.resource_group_name
    kind                   = "Linux"
    reserved               = true  
  
  sku {
    tier = "Standard"
    size = "s1"
  }
}

resource "azurerm_app_service" "mdcs-azas" {
    name                = var.app_service_name
    location            = azurerm_app_service_plan.mdcs-azsp.location
    resource_group_name = azurerm_app_service_plan.mdcs-azsp.resource_group_name
    app_service_plan_id = azurerm_app_service_plan.mdcs-azsp.id

    site_config {
      linux_fx_version = "NODE|12-lts"
    }
}
