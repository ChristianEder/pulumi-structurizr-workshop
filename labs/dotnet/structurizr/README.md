# Getting started with structurizr

## Prerequisites

> If you are doing this as part of the workshop [labs](../../../README.md), you should be fine by now, and can skip the Prerequisites section.

Otherwise, make sure you have the following tools installed:

- [.NET Core SDK](https://dotnet.microsoft.com/download). You can verify this by running the following command on the command line:
  > dotnet --version
- [VS Code](https://code.visualstudio.com/)
- PlantUml (optional, only required for visualizing the architecture diagrams locally)
- GraphViz (optional, only required for visualizing the architecture diagrams locally)
- The `jebbs.plantuml` extension for VS Code (optional, only required for visualizing the architecture diagrams locally)

The easiest way to install those is to use [chocolatey](https://chocolatey.org/install):
> choco install dotnetcore-sdk vscode plantuml graphviz

## Lab tasks

### 01 - Verify that your setup works

- Open this repositories folder in VS Code
- Open a terminal in VS Code
- Try visualizing the current state of the provided architecture model. The steps to do this are descibed in the cheat sheet section below
- Compare the generated diagrams with the source code provided in [Program.cs](Program.cs) within the same directory as this README, in order to get a feeling for what the code actually does.

### 02 - Customize the architecture model

You can now go ahead and start designing your architecture by changing the code in [Program.cs](Program.cs).

You can either do this free style e.g. by starting from scratch and designing the actual architecture of one of your own systems, or you can start extending the provided example architecture model with some additional containers, surrounding systems or users. 

Ideas for extensions of the existing model:
- Add a new container that represents an administrative site used to manage the shops inventory, then add a new person "Inventory manager" using that site
- Add a new container in between the 'shopWebsite' and the 'paymentProviderIntegration' that represents a queue that the 'shopWebsite' uses to communicate with the 'paymentProviderIntegration'
- Add another container view that only shows the containers involved in inventory management (using the containerView.addContainer function instead of containerView.addAllContainers)
- Try to automatically create a container view with only specific containers (like in the step before), by applying tags to containers, and then adding only container with that tag to the view

## Cheatsheet

All of the commands shown below are intended to be run on a command line from the same directory as this README file.

- How to verify that my code builds?
  > dotnet build
- How to visualize the architecture model I created?
  > dotnet run
  - open the newly generated file `out/architecture.puml` in VS Code
  - Press F1
  - Select `PlantUML: Preview Current Diagram`
  - Navigate throught the different sections of the `out/architecture.puml` file
