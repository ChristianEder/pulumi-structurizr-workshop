resource "azurerm_resource_group" "rg" {
  name     = "resourceGroupName"
  location = "West Europe"
}

resource "azurerm_app_service_plan" "webapp" {
  name                = "test-web-app"
  location            = "${azurerm_resource_group.rg.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"

  sku {
    tier = "Free"
    size = "F1"
  }
}

resource "azurerm_app_service" "webapp" {
  name                = "test-web-app"
  location            = "${azurerm_resource_group.rg.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  app_service_plan_id = "${azurerm_app_service_plan.webapp.id}"
}

output "url" {
  description = "The url of the web app."
  value       = "${azurerm_app_service.webapp.defaultHostname}"
}