using Structurizr;

internal class PaymentProvider
{
    public SoftwareSystem System { get; private set; }

    public PaymentProvider(Workspace workspace, Person customer)
    {
        System = workspace.Model.AddSoftwareSystem(Location.External,  "Payment Provider", "Online payment provider");
        customer.Uses(System, "pay for stuff");
    }
}