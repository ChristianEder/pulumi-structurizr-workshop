import { Workspace, Location, InteractionStyle, StructurizrClient, PlantUMLWriter } from "structurizr-typescript"
import * as fs from "fs";

var workspace = new Workspace();
workspace.name = "Your workspace name";

var shop = workspace.model.addSoftwareSystem("Shop", "Online shopping system")!;
shop.location = Location.Internal;

var paymentProvider = workspace.model.addSoftwareSystem("Payment Provider", "Online payment provider")!;
paymentProvider.location = Location.External;

shop.uses(paymentProvider, "process customer payments");

var user = workspace.model.addPerson("Customer", "uses the shop to buy stuff")!;
user.uses(shop, "buy stuff");
user.uses(paymentProvider, "pay for stuff");

var shopWebsite = shop.addContainer("Website", "Lets users buy stuff", "Shopware hosted on Azure")!;
var productDatabase = shop.addContainer("Database", "stores available products and customer orders", "SQL Database")!;
var paymentProviderIntegration = shop.addContainer("Payment integration", "Manages integration of the payment provider", "Azure function calling out to PayPal")!;
shopWebsite.uses(productDatabase, "Load product data, save customer orders");
shopWebsite.uses(paymentProviderIntegration, "fulfill payments")
paymentProviderIntegration.uses(paymentProvider, "fulfil payments");
paymentProviderIntegration.uses(productDatabase, "mark orders as paid");

user.uses(shopWebsite, "buy stuff");

var systemContext = workspace.views.createSystemContextView(shop, "shop-context", "The system context view for the shop");
systemContext.addNearestNeighbours(shop);

var containerView = workspace.views.createContainerView(shop, "shop-containers", "Container view for the shop");
containerView.addAllContainers();
containerView.addNearestNeighbours(shop);

var plantUmlExport = new Promise((resolve, reject) => {
    const plantUML = new PlantUMLWriter().toPlantUML(workspace);
    fs.writeFile("out\\architecure.puml", plantUML, e => {
        if(e){
            reject(e);
        }
        resolve();
    });
});
plantUmlExport.then(() => {
    console.log("done");
}).catch(e => {
    console.log("error", e);
});