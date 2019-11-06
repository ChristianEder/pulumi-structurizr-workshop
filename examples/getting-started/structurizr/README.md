# Getting started with structurizr

## Prerequisites

> If you are doing this as part of the workshop [labs](../../../labs.md), you should be fine by now, and can skip the Prerequisites section.

Otherwise, make sure you have the following tools installed:

- [NodeJS](https://nodejs.org/en/). You can verify this by running the following command on the command line:
  > npm -v
- VS Code
- PlantUml
- GraphViz

The easiest way to install those is to use [chocolatey](https://chocolatey.org/install):
> choco install nodejs.install vscode plantuml graphviz

You'll also need to install the following VS Code extension:
- jebbs.plantuml

Also, if you are not doing this lab on one of the provided development VMs, you will initially have to install npm dependencies, by running the following command within the same directory as this README:

> npm i

## Lab tasks

### 01 - Verify that your setup works

- Open the repository folder (`C:\repos\pulumi-structurizr-workshop`) in VS Code
- Open a terminal
- Try visualizing the current state of the provided architecture model. The steps to do this are descibed in the cheat sheet section below
- Compare the generated diagrams with the source code provided in [index.ts](index.ts) within the same directory as this README, in order to get a feeling for what the code actually does.

### 02 -  Customize the architecture model

You can now go ahead and start designing your architecture by changing the code in [index.ts](index.ts).

You can either do this free style e.g. by starting from scractch and designing the actual architecture of one of your own systems, or you can start extending the provided example architecture model with some additional containers, surrounding systems or users. 

Ideas for extensions of the existing model:
- Add a new container that represents an administrative site used to manage the shops inventory, then add a new person "Inventory manager" using that site
- Add a new container in between the 'shopWebsite' and the 'paymentProviderIntegration' that represents a queue that the 'shopWebsite' uses to communicate with the 'paymentProviderIntegration'
- Add another container view that only shows the containers involved in inventory management (using the containerView.addContainer function instead of containerView.addAllContainers)
- Try to automatically create a container view with only specific containers (like in the step before), by applying tags to containers, and then adding only container with that tag to the view

## Cheatsheet

All of the commands shown below are intended to be run on a command line from the same directory as this README file.

- How to verify that my code builds?
  > npm run build
- How to visualize the architecture model I created?
  > npm start
  - open the newly generated file `out/architecture.puml` in VS Code
  - Press F1
  - Select `PlantUML: Preview Current Diagram`
  - Navigate throught the different sections of the `out/architecture.puml` file
