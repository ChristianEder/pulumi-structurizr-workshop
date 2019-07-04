import * as azure from "@pulumi/azure"
import * as pulumi from "@pulumi/pulumi";

const resourceGroup = new azure.core.ResourceGroup("resourceGroupName", {
  location: azure.Locations.WestEurope,
});

const plan = new azure.appservice.Plan("test-web-app", {
  resourceGroupName: resourceGroup.name,
  sku: {
    tier: "Free",
    size: "F1",
  }
});

const app = new azure.appservice.AppService("test-web-app", {
  resourceGroupName: resourceGroup.name,
  appServicePlanId: plan.id
});

export const url = pulumi.interpolate`https://${app.defaultSiteHostname}`;



const resourceGroups = ["euwest", "uscentral"].map(location => new azure.core.ResourceGroup(`test-web-app-${location}`, { location }));