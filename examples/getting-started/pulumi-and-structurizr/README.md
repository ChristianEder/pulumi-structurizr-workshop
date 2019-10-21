# Getting started with structurizr
- After installing the required dependencies...
  - NodeJS (https://nodejs.org/en/)

You can now go ahead and start designing your architecture by changing the code in index.ts
You can visualize your architecture diagram by
- Running
  > npm run architecture
- opening the newly generated file `out/architecture.puml` n VS Code
- Showing the diagram in VS Code by
  - Press F1
  - Select `PlantUML: Preview Current Diagram`
  - Navigate throught the different sections of the `out/architecture.puml` file

# Getting started with pulumi Azure

- After installing the required dependencies...
  - pulumi (see install-pulumi.ps1 within this repo, or visit https://www.pulumi.com/docs/get-started/install/)
  - NodeJS (https://nodejs.org/en/)
  - az CLI (https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)

You can now deploy the described infrastructure to Azure by
- Logging in to your Azure subscription
  > az login
- Using pulumi to deploy the infrastructure
  > pulumi up