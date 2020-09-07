# Getting started with pulumi

## Prerequisites

> If you are doing this as part of the workshop [labs](../../../README.md), you should be fine by now, and can skip the Prerequisites section - except if you want to actually create cloud infrastructure within this lab. In that case, please read the last part of this section.

Otherwise, make sure you have the following tools installed:

- [.NET Core SDK](https://dotnet.microsoft.com/download). You can verify this by running the following command on the command line:
  > dotnet --version
- [VS Code](https://code.visualstudio.com/)
- [pulumi](https://www.pulumi.com/docs/get-started/install/)

The easiest way to install those is to use [chocolatey](https://chocolatey.org/install):
> choco install dotnetcore-sdk vscode

Pulumi can easily be installed via a powershell script shown at their [website](https://www.pulumi.com/docs/get-started/install/)

**If you want to actually create cloud infrastructure** from the code provided, you will also need the following tools setup:

- If you are using Azure, install the [az CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) and run the following command to login to your subscription:
  > az login
- If you are using AWS, install the [AWS CLI](https://aws.amazon.com/de/cli/) and run the following command to login to your account:
  > aws configure

## Lab tasks

### 01 - Get familiar with the code

- Open thi repositories folder in VS Code
- Choose a cloud provider. Examples for AWS and Azure are provided within subdirectories beside this README
- Open the MyStack.cs file within the chosen cloud provider subdirectory and try to understand whats going on in there
  - For Azure, go to [azure/MyStack.cs](azure/MyStack.cs)
  - For AWS, go to [aws/MyStack.cs](aws/MyStack.cs)

### 02 - Customize the created infrastructure

You can now go ahead and start coding your infrastructure by changing the code in the MyStack.cs file.

You can either do this free style e.g. by starting from scratch and coding the actual infrastructure of one of your own systems, or you can start extending the provided example infrastructure with more resources & services, connecting them together. 

Ideas for extensions of the existing infrastructure (based on the 'webshop' example used in the [structurizr lab](../structurizr/README.md)):
- Add a website hosting the shop frontend
  - For Azure users, you could start exploring the `Pulumi.Azure.AppService` namespace
  - For AWS users, the `Pulumi.Aws.ElasticBeanstalk` namespace might contain what you are searching for
- Add a database to store shop product data in
  - Azure users might get started with an `Pulumi.Azure.Storage.Table` or something from the `Pulumi.Azure.Sql` namespace
  - AWS users might find something useful in the `Pulumi.Aws.DynamoDB` namespace
- Connect the website to the database by adding the connection secrets to the websites configuration
  - Azure users that created an AppService, can configure this using the `AppSettings` property in the args provided to the constructor of the AppService
  - AWS users than created an Elastic Beanstalk environment, can configure this using the `Settings` property in the args provided to the constructor of the Environment
- Experiment with the capabilities of a real programming language for infrastructure as code
  - Refactor the creation of some infrastructure components into separate files
  - Create loops that create multiple similar resources - or use LINQ / `.Select().ToArray()` on arrays to create multiple resources from an array of configuration values used to parametrize the resources created
  - Conditionally create resources 
- Explore more pulumi examples at
  - https://github.com/pulumi/examples
  - https://github.com/pulumi/pulumi-azure/tree/master/examples
  - https://github.com/pulumi/pulumi-aws/tree/master/examples

## Cheatsheet

All of the commands shown below are intended to be run on a command line from the directory that contains the `.csproj` file you are working in for the cloud provider you chose.

- How to verify that my code builds?
  > pulumi preview

  This will build your code and visualizes the changes pulumi intends to perform
- How to deploy the infrastructure to my cloud environment?
  > pulumi up → [Yes]
