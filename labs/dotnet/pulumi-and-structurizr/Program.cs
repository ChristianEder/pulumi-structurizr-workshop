using System.IO;
using System.Linq;
using System.Threading.Tasks;
using Pulumi;
using Pulumi.Azure.AppService;
using Pulumi.Azure.Core;
using Structurizr;
using Structurizr.IO.PlantUML;

partial class Program
{
    static Task<int> Main(string[] args)
    {
        var workspace = new Workspace("Your workspace name", "Some description");

        var customer = workspace.Model.AddPerson("Customer", "uses the shop to buy stuff");
        var paymentProvider = new PaymentProvider(workspace, customer);
        var shop = new Shop(workspace, paymentProvider, customer);

        if (args.Any(a => a.Equals("architecture", System.StringComparison.OrdinalIgnoreCase)))
        {
            ExportPlantUML(workspace);
            return Task.FromResult(0);
        }

        return Deployment.RunAsync(()=>
        {
            shop.DefineInfrastructure();
        });
    }
    private static void ExportPlantUML(Workspace workspace)
    {
        using var stringWriter = new StringWriter();
        new PlantUMLWriter().Write(workspace, stringWriter);
        stringWriter.Flush();
        var puml = stringWriter.ToString();

        Directory.CreateDirectory("out");
        File.WriteAllText(Path.Combine("out", "architecure.puml"), puml);
    }


}
