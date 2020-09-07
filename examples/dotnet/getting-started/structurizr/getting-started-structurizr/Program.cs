using Structurizr;
using Structurizr.IO.PlantUML;
using System.IO;

namespace getting_started_structurizr
{
    class Program
    {
        static void Main(string[] args)
        {
            var (workspace, shop) = CreateArchitectureModel();
            CreateDiagrams(workspace, shop);
            ExportPlantUML(workspace);
        }

        private static (Workspace, SoftwareSystem) CreateArchitectureModel()
        {
            // A workspace is the home for your complete architecture model
            var workspace = new Workspace("Your workspace name", "Some description");

            // A software system is the top level item of architectural elements you
            // can describe in an architecture model.
            // The `shop` created below is the system that we are modeling here
            var shop = workspace.Model.AddSoftwareSystem(Location.Internal, "Shop", "Online shopping system");

            // We can add more than 1 system to the same architecture model.
            // In this case, we add another, external system that we use to model
            // external dependencies of our `shop` system
            var paymentProvider = workspace.Model.AddSoftwareSystem(Location.External, "Payment Provider", "Online payment provider")!;

            // This models a dependency from one system to another
            shop.Uses(paymentProvider, "process customer payments");

            // Also, we can add people interacting with those systems and 
            // model their interactions
            var user = workspace.Model.AddPerson("Customer", "uses the shop to buy stuff")!;
            user.Uses(shop, "buy stuff");
            user.Uses(paymentProvider, "pay for stuff");

            // By adding containers to a software system, we dive 1 layer
            // deeper into modeling our architecture. Containers are typically
            // `things that do / provide something at runtime`
            var shopWebsite = shop.AddContainer("Website", "Lets users buy stuff", "Shopware hosted on Azure")!;
            var productDatabase = shop.AddContainer("Database", "stores available products and customer orders", "SQL Database")!;
            var paymentProviderIntegration = shop.AddContainer("Payment integration", "Manages integration of the payment provider", "Azure function calling out to PayPal")!;

            // We can model dependencies between containers, as well as from containers
            // to other systems
            shopWebsite.Uses(productDatabase, "Load product data, save customer orders");
            shopWebsite.Uses(paymentProviderIntegration, "fulfill payments");
            paymentProviderIntegration.Uses(paymentProvider, "fulfil payments");
            paymentProviderIntegration.Uses(productDatabase, "mark orders as paid");

            // Also, we can model which containers inside a system the people specifically interact with
            user.Uses(shopWebsite, "buy stuff");

            return (workspace, shop);
        }

        private static void CreateDiagrams(Workspace workspace, SoftwareSystem shop)
        {
            // At this point, we are done with modeling the architecture.
            // The code that follows, is describing the views that we want to
            // generate onto the model we described above

            // A system context view shows 1 or more systems - as the name suggests - in context
            // By adding nearest neighbours, we will automatically see all elements
            // that have a direct dependency (either way) with the shop system
            // This includes the `user` person and `paymentProvider` system
            var systemContext = workspace.Views.CreateSystemContextView(shop, "shop-context", "The system context view for the shop");
            systemContext.AddNearestNeighbours(shop);

            // A container view shows either some or all containers of a system
            // and their dependencies to one another
            // Again, we can add neighbouring systems, containers, people to add 
            // more context to the diagram
            var containerView = workspace.Views.CreateContainerView(shop, "shop-containers", "Container view for the shop");
            containerView.AddAllContainers();
            containerView.AddNearestNeighbours(shop);
        }

        private static void ExportPlantUML(Workspace workspace)
        {
            using var stringWriter = new StringWriter();
            new PlantUMLWriter().Write(workspace, stringWriter);
            stringWriter.Flush();
            var puml = stringWriter.ToString();
            File.WriteAllText(Path.Combine("out", "architecure.puml"), puml);
        }
    }
}
