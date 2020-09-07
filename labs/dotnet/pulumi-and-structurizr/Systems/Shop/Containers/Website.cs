using Pulumi.Azure.AppService;
using Pulumi.Azure.AppService.Inputs;

internal class Website
{
    private readonly Shop shop;
    private readonly ProductDatabase productDatabase;
    private readonly PaymentProviderIntegration paymentProviderIntegration;

    public Structurizr.Container Container { get; private set; }
    public (Plan Plan, AppService App) Infrastructure { get; private set; }

    public Website(Shop shop, ProductDatabase productDatabase, PaymentProviderIntegration paymentProviderIntegration)
    {
        Container = shop.System.AddContainer("Website", "Lets users buy stuff", "Shopware hosted on Azure")!;
        Container.Uses(productDatabase.Container, "Load product data, save customer orders");
        Container.Uses(paymentProviderIntegration.Container, "fulfill payments");
        shop.Customer.Uses(Container, "buy stuff");
        this.shop = shop;
        this.productDatabase = productDatabase;
        this.paymentProviderIntegration = paymentProviderIntegration;
    }

    public void DefineInfrastructure()
    {
        var plan = new Plan("website", new PlanArgs
        {
            ResourceGroupName = shop.ResourceGroup.Name,
            Kind = "App",
            Sku = new PlanSkuArgs
            {
                Tier = "Free",
                Size = "F1"
            }
        });

        var app = new AppService("website", new AppServiceArgs
        {
            ResourceGroupName = shop.ResourceGroup.Name,
            AppServicePlanId = plan.Id,
            AppSettings = new Pulumi.InputMap<string>
        {
                { "PRODUCTS_CONNECTION_STRING", productDatabase.Infrastructure.Account.PrimaryConnectionString},
                { "PRODUCTS_TABLE_NAME", productDatabase.Infrastructure.Products.Name },
                { "PAYMENTS_TABLE_NAME", productDatabase.Infrastructure.Payments.Name },
                { "PAYMENTS_CONNECTION_STRING", paymentProviderIntegration.Infrastructure.Account.PrimaryConnectionString },
                { "PAYMENTS_QUEUE_NAME", paymentProviderIntegration.Infrastructure.Queue.Name }
            }
        });

        Infrastructure = (plan, app);
    }
}