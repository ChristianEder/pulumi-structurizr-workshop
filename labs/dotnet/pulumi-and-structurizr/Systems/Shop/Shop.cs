using Pulumi.Azure.Core;
using Structurizr;

internal class Shop
{

    public Shop(Workspace workspace, PaymentProvider paymentProvider, Person customer)
    {
        System = workspace.Model.AddSoftwareSystem(Location.Internal, "Shop", "Online shopping system")!;
        System.Uses(paymentProvider.System, "process customer payments");
        customer.Uses(System, "buy stuff");
        Customer = customer;

        var productDatabase = new ProductDatabase(this);
        var paymentProviderIntegration = new PaymentProviderIntegration(this, paymentProvider, productDatabase);
        var website = new Website(this, productDatabase, paymentProviderIntegration);
        Containers = (
            productDatabase, 
            paymentProviderIntegration,
            website);
    }

    public SoftwareSystem System { get; }
    public Person Customer{ get; }

    public (ProductDatabase ProductDatabase, PaymentProviderIntegration PaymentProviderIntegration, Website Website) Containers { get; }

    public ResourceGroup ResourceGroup { get; private set; }

    public void DefineInfrastructure()
    {
        ResourceGroup = new ResourceGroup("shop", new ResourceGroupArgs
        {
            Location = "WestEurope"
        });

        Containers.ProductDatabase.DefineInfrastructure();
        Containers.PaymentProviderIntegration.DefineInfrastructure();
        Containers.Website.DefineInfrastructure();
    }
}
