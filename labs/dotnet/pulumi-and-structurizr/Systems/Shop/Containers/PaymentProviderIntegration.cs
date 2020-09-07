using Pulumi.Azure.AppService;
using Pulumi.Azure.AppService.Inputs;
using Pulumi.Azure.Storage;

internal class PaymentProviderIntegration
{
    private readonly Shop shop;
    private readonly ProductDatabase productDatabase;

    public Structurizr.Container Container { get; private set; }

    public (Account Account, Queue Queue, FunctionApp FunctionApp) Infrastructure { get; private set; }


    public PaymentProviderIntegration(Shop shop, PaymentProvider paymentProvider, ProductDatabase productDatabase)
    {
        Container = shop.System.AddContainer("Payment integration", "Manages integration of the payment provider", "Azure function calling out to PayPal")!;
        Container.Uses(paymentProvider.System, "fulfil payments");
        Container.Uses(productDatabase.Container, "mark orders as paid");
        this.shop = shop;
        this.productDatabase = productDatabase;
    }
    public void DefineInfrastructure()
    {
        var storage = new Account("payment", new AccountArgs
        {
            ResourceGroupName = shop.ResourceGroup.Name,
            AccountReplicationType = "LRS",
            AccountTier = "Standard",
        });

        var queue = new Queue("payments", new QueueArgs
        {
            StorageAccountName = storage.Name,
        });

        var plan = new Plan("process-payment", new PlanArgs
        {
            ResourceGroupName = shop.ResourceGroup.Name,
            Kind = "FunctionApp",
            Sku = new PlanSkuArgs
            {
                Tier = "Dynamic",
                Size = "Y1"
            }
        });

        var functionApp = new FunctionApp("process-payment", new FunctionAppArgs
        {
            ResourceGroupName = shop.ResourceGroup.Name,
            AppServicePlanId = plan.Id,
            StorageAccountName = storage.Name,
            StorageAccountAccessKey = storage.PrimaryAccessKey,
            AppSettings = new Pulumi.InputMap<string>
            {
                {"QueueConnectionString", storage.PrimaryConnectionString }
            }

        });

        Infrastructure = (storage, queue, functionApp);
    }
}
