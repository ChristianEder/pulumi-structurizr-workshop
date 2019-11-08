# Workshop instructions

Welcome to this workshop covering architecture as code and infrastructure as code. Please follow the steps described and linked below.

The introductory slides can be found as [PDF](slides/architecure-infrastructure-as-code/Architecture&#32;&&#32;Infrastructure&#32;As&#32;Code.pdf) and [Powerpoint](slides/architecure-infrastructure-as-code/Architecture&#32;&&#32;Infrastructure&#32;As&#32;Code.pptx), and there is also an [introductory slidedeck for pulumi](https://christianeder.github.io/pulumi-structurizr-workshop/slides/pulumi-tf-arm) comparing it to Terraform and ARM templates.

## Setup your machine

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
- VS Code
- PlantUML
- GraphViz
- Azure CLI
- Pulumi

They will then continue to perform the following operations:

- Configure your pulumi installation to use a local filesystem state store: `pulumi login --local`
- Install a bunch of VS Code extensions useful for this lab
- Install npm dependencies in all sample projects contained in this repository 

## Choose your focus for the workshop

Depending on the knowledge you already bring to this workshop and on your main area of interest, you can choose to be working on different aspects:

- Architecture as Code with structurizr → see [labs](examples/getting-started/structurizr/README.md)
- Infrastructure as Code with pulumi → see [labs](examples/getting-started/pulumi/README.md)
- Combining architecture & infrastructure as code → see [labs](examples/getting-started/pulumi-and-structurizr/README.md)
  - this lab is intended for advanced users that are already comfortable with either structurizr or pulumi