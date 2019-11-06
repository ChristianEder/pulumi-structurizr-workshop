# Getting started with pulumi

## Prerequisites

> If you are doing this as part of the workshop [labs](../../../README.md), you should be fine by now, and can skip the Prerequisites section.

Otherwise, make sure you have the following tools installed:

- [NodeJS](https://nodejs.org/en/). You can verify this by running the following command on the command line:
  > npm -v
- [VS Code](https://code.visualstudio.com/)
- [pulumi](https://www.pulumi.com/docs/get-started/install/)

The easiest way to install those is to use [chocolatey](https://chocolatey.org/install):
> choco install nodejs.install vscode

Pulumi can easily be installed via a powershell script shown at their [website](https://www.pulumi.com/docs/get-started/install/)

Also, if you are not doing this lab on one of the provided development VMs, you will initially have to install npm dependencies, by running the following command within the azure or aws subdirectory of the directory of this README:

> npm i

If you want to actually create cloud infrastructure from the code provided, you will also need the following tools setup:

- If you are using Azure, install the [az CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) and run the following command to login to your subscription:
  > az login
- If you are using AWS, install the [AWS CLI](https://aws.amazon.com/de/cli/) and run the following command to login to your account:
  > aws configure

## Lab tasks

### 01 - Get familiar with the code

- Open the repository folder (`C:\repos\pulumi-structurizr-workshop`) in VS Code
- Choose a cloud provider. Examples for AWS and Azure are provided within subdirectories beside this README
- Open the index.ts file within the chose cloud provider subdirectory and try to understand whats going on in there
  - For Azure, go to [azure/index.ts](azure/index.ts)
  - For AWS, go to [aws/index.ts](aws/index.ts)

### 02 - Customize the created infrastructure

You can now go ahead and start coding your infrastructure by changing the code in the index.ts file.

You can either do this free style e.g. by starting from scratch and coding the actual infrastructure of one of your own systems, or you can start extending the provided example infrastructure with more resources & services, connecting them together. 

Ideas for extensions of the existing infrastructure (based on the 'webshop' example used in the [structurizr lab](../structurizr/README.md)):
- Add a website hosting the shop frontend
  - For Azure users, you could start exploring the `azure.appservice` module
  - For AWS user, the `aws.elasticbeanstalk` module might contain what you are searching for
- Add a database to store shop product data in
  - Azure users might get started with an `azure.storage.Table` or something from the `azure.sql` module
  - AWS users might find something useful in the `aws.dynamodb` module
- Connect the website to the database by adding the connection secrets to the websites configuration
  - Azure users that created an AppService, can configure this using the `appSettings` property in the args provided to the constructor of the AppService
  - AWS users than created an Elastic Beanstalk environment, can configure this using the `settings` property in the args provided to the constructor of the Environment
- Experiment with the capabilities of a real programming language for infrastructure as code
  - Refactor the creation of some infrastructure components into separate files
  - Create loops that create multiple similar resources - or use JavaScripts `map` function on arrays to create multiple resources from an array of configuration values used to parametrize the resources created
  - Conditionally create resources using conditions like `if(pulumi.getStack() === 'production')` 
  - Use pulumi to not only create resources, but also write production code and deploy it to those resources
    - Azure users can easily create an API using Azure Functions by using the `azure.appservice.HttpEventSubscription` and its `callback` parameter
    - AWS users can do the same using the `aws.serverless.Function` class
- Explore more pulumi examples at
  - https://github.com/pulumi/examples
  - https://github.com/pulumi/pulumi-azure/tree/master/examples
  - https://github.com/pulumi/pulumi-aws/tree/master/examples

## Cheatsheet

All of the commands shown below are intended to be run on a command line from the directory that contains the index.ts file you are working in for the cloud provider you chose.

- How to verify that my code builds?
  > pulumi up

  This will build your code and visualizes the changes pulumi intends to perform
- How to deploy the infrastructure to my cloud environment?
  > pulumi up → [Yes]
