import * as azure from "@pulumi/azure";

const resourceGroup = new azure.core.ResourceGroup("resourceGroup");

const dedicatedPlan = new azure.appservice.Plan("dedicated", {
    resourceGroupName: resourceGroup.name,
    kind: 'Linux',
    sku: {
        tier: 'F1',
        size: '1'
    }
});

const consumptionPlan = new azure.appservice.Plan("consumption", {
    resourceGroupName: resourceGroup.name,
    kind: 'FunctionApp',
    sku: {
        tier: 'Dynamic',
        size: 'Y1'
    }
});

const app1 = new azure.appservice.FunctionApp("app1", {
    resourceGroupName: resourceGroup.name,
    appServicePlanId: dedicatedPlan.id
});

const app2 = new azure.appservice.FunctionApp("app2", {
    resourceGroupName: resourceGroup.name,
    appServicePlanId: consumptionPlan.id
});