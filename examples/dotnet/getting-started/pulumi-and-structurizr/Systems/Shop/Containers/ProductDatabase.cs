using Pulumi.Azure.Storage;

internal class ProductDatabase
{
    private readonly Shop shop;

    public Structurizr.Container Container { get; private set; }
    public (Account Account, Table Products, Table Payments) Infrastructure { get; private set; }

    public ProductDatabase(Shop shop)
    {
        Container = shop.System.AddContainer("Database", "stores available products and customer orders", "SQL Database");
        this.shop = shop;
    }

    public void DefineInfrastructure()
    {
        var account = new Account("product", new AccountArgs
        {
            ResourceGroupName = shop.ResourceGroup.Name,
            AccountTier = "Standard",
            AccountReplicationType = "LRS"
        });

        var products = new Table("products", new TableArgs
        {
            Name = "products",
            StorageAccountName = account.Name
        });


        var payments = new Table("payments", new TableArgs
        {
            Name = "payments",
            StorageAccountName = account.Name
        });

        Infrastructure = (account, products, payments);
    }
}
