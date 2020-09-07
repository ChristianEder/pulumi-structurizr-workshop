import { Workspace, Location, InteractionStyle, StructurizrClient, PlantUMLWriter } from 'structurizr-typescript'
import * as fs from 'fs';

// A workspace is the home for your complete architecture model
const workspace = new Workspace();
workspace.name = 'Your workspace name';

// A software system is the top level item of architectural elements you
// can describe in an architecture model.
// The `shop` created below is the system that we are modeling here
const shop = workspace.model.addSoftwareSystem('Shop', 'Online shopping system')!;
shop.location = Location.Internal;

// We can add more than 1 system to the same architecture model.
// In this case, we add another, external system that we use to model
// external dependencies of our `shop` system
const paymentProvider = workspace.model.addSoftwareSystem('Payment Provider', 'Online payment provider')!;
paymentProvider.location = Location.External;

// This models a dependency from one system to another
shop.uses(paymentProvider, 'process customer payments');

// Also, we can add people interacting with those systems and 
// model their interactions
const user = workspace.model.addPerson('Customer', 'uses the shop to buy stuff')!;
user.uses(shop, 'buy stuff');
user.uses(paymentProvider, 'pay for stuff');

// By adding containers to a software system, we dive 1 layer
// deeper into modeling our architecture. Containers are typically
// `things that do / provide something at runtime`
const shopWebsite = shop.addContainer('Website', 'Lets users buy stuff', 'Shopware hosted on Azure')!;
const productDatabase = shop.addContainer('Database', 'stores available products and customer orders', 'SQL Database')!;
const paymentProviderIntegration = shop.addContainer('Payment integration', 'Manages integration of the payment provider', 'Azure function calling out to PayPal')!;

// We can model dependencies between containers, as well as from containers
// to other systems
shopWebsite.uses(productDatabase, 'Load product data, save customer orders');
shopWebsite.uses(paymentProviderIntegration, 'fulfill payments');
paymentProviderIntegration.uses(paymentProvider, 'fulfil payments');
paymentProviderIntegration.uses(productDatabase, 'mark orders as paid');

// Also, we can model which containers inside a system the people specifically interact with
user.uses(shopWebsite, 'buy stuff');

// At this point, we are done with modeling the architecture.
// The code that follows, is describing the views that we want to
// generate onto the model we described above

// A system context view shows 1 or more systems - as the name suggests - in context
// By adding nearest neighbours, we will automatically see all elements
// that have a direct dependency (either way) with the shop system
// This includes the `user` person and `paymentProvider` system
const systemContext = workspace.views.createSystemContextView(shop, 'shop-context', 'The system context view for the shop');
systemContext.addNearestNeighbours(shop);

// A container view shows either some or all containers of a system
// and their dependencies to one another
// Again, we can add neighbouring systems, containers, people to add 
// more context to the diagram
const containerView = workspace.views.createContainerView(shop, 'shop-containers', 'Container view for the shop');
containerView.addAllContainers();
containerView.addNearestNeighbours(shop);

// Now that we finished modeling the architecture and describing
// the views onto the model, we can either export the model
// to plant uml, or we can upload it to structurizr.com, a
// hosted backend to store architecture models and render diagrams.
const plantUmlExport = new Promise((resolve, reject) => {
    const plantUML = new PlantUMLWriter().toPlantUML(workspace);
    fs.writeFile('out\\architecure.puml', plantUML, e => {
        if(e){
            reject(e);
        }
        resolve();
    });
});
plantUmlExport.then(() => {
    console.log('done');
}).catch(e => {
    console.log('error', e);
});