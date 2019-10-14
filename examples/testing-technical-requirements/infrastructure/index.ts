import * as azure from '@pulumi/azure'
import * as pulumi from '@pulumi/pulumi';

export const resourceGroup = new azure.core.ResourceGroup('resourceGroupName', {
  location: azure.Locations.WestEurope,
});

export const plan = new azure.appservice.Plan('test-web-app', {
  resourceGroupName: resourceGroup.name,
  sku: {
    tier: 'Free',
    size: 'F1',
  }
});

export const app = new azure.appservice.AppService('test-web-app', {
  resourceGroupName: resourceGroup.name,
  appServicePlanId: plan.id,
  httpsOnly: true
});

export const url = pulumi.interpolate`https://${app.defaultSiteHostname}`;


