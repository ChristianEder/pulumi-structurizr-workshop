# Workshop instructions

Welcome to this workshop covering architecture as code and infrastructure as code. Please follow the steps described and linked below.

The introductory slides can be found as [PDF](slides/architecure-infrastructure-as-code/Architecture&#32;&&#32;Infrastructure&#32;As&#32;Code.pdf) and [Powerpoint](slides/architecure-infrastructure-as-code/Architecture&#32;&&#32;Infrastructure&#32;As&#32;Code.pptx), and there is also an [introductory slidedeck for pulumi](https://christianeder.github.io/pulumi-structurizr-workshop/slides/pulumi-tf-arm) comparing it to Terraform and ARM templates.

## Setup your machine

### Scripted setup

***Please note: the steps & scripts mentioned below install both mandatory & optional software to perform the workshop. If you wish to leave out the optional parts, please follow the manual setup instructions***

While parts of the workshop will also work on non-Windows machines, the following steps are designed to be performed from a Windows Powershell. If you want to work from a different operating system, or do not want to use the provided scripts in order to install dependencies, please find a list of all required software at the end of this section.

Please also note that the scripts used below will install or might upgrade software on your computer. If you do not want some of the software installed, please either don't use the scripts or manipulate them before usage.

The only dependency you'll need to install beforehand is [git](https://gitforwindows.org/).

After that, you can choose to

- git clone this repo manually to a destination of your choice, navigate into the repo folder, and then call
  > .\scripts\setup.ps1
  - you might have to enable PowerShell script execution first, if the previous call fails
    > Set-ExecutionPolicy RemoteSigned
- Or, you could just navigate to the intended parent folder to clone this repo into, and then call
  > Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/ChristianEder/pulumi-structurizr-workshop/master/scripts/clone_and_setup.ps1'))
  - this will clone the repository into a subfolder of your current working directory, cd into that, and then call the same setup.ps1 script described above.

The scripts will install the following software

- Chocolatey, a tool used to perform all the following installations
- NodeJS
- .NET Core SDK
- VS Code
- PlantUML
- GraphViz
- Azure CLI
- Pulumi

They will then continue to perform the following operations:

- Configure your pulumi installation to use a local filesystem state store: `pulumi login --local`
- Install a bunch of VS Code extensions useful for this lab
- Install npm dependencies in all sample projects contained in this repository 

### Manual setup

You will need to install the following tools:

- An IDE of your choice, e.g. [VS Code](https://code.visualstudio.com/download)
- The runtime of your choice. You can do the workshop either with [.NET Core](https://dotnet.microsoft.com/download) or [NodeJS](https://nodejs.org/en/)

Optionally, you'll need the following tools:

- If you want preview the resources created by your infrastrucure code (or actually created the resources), you'll need:
  - [Pulumi CLI](https://www.pulumi.com/docs/get-started/install/)
  - After pulumi is installed, you'll need to follow the cloud provicer [setup instructions](https://www.pulumi.com/docs/get-started/). E.g. for Azure, you'll need to install the [az CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest), run `az login` to login to your subscription, and `pulumi login --local` if you don't have a pulumi account, or `pulumi login` if you do.
- If you want to visually preview your architecture code, you'll need to install [PlantUML](https://chocolatey.org/packages/plantuml) and [Graphviz](https://chocolatey.org/packages/graphviz), and ideally the `jebbs.plantuml` extension for VS Code.

## Choose your focus for the workshop

Depending on the knowledge you already bring to this workshop and on your main area of interest, you can choose to be working on different aspects:

- Architecture as Code with structurizr → see [.NET Core labs](examples/dotnet/getting-started/structurizr/README.md) or [NodeJS labs](examples/nodejs/getting-started/structurizr/README.md)
- Infrastructure as Code with pulumi → see [.NET Core labs](examples/dotnet/getting-started/pulumi/README.md) or [NodeJS labs](examples/nodejs/getting-started/pulumi/README.md)
- Combining architecture & infrastructure as code → see [.NET Core labs](examples/dotnet/getting-started/pulumi-and-structurizr/README.md) or [NodeJS labs](examples/nodejs/getting-started/pulumi-and-structurizr/README.md)
  - this lab is intended for advanced users that are already comfortable with either structurizr or pulumi