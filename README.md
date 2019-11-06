# Workshop instructions

Welcome to this workshop covering architecture as code and infrastructure as code. Please follow the steps described and linked below.

The introductory slides can be found [here](slides/architecure-infrastructure-as-code/Architecture&#32;&&#32;Infrastructure&#32;As&#32;Code.pptx), and there is also an [introductory slidedeck for pulumi](https://christianeder.github.io/pulumi-structurizr-workshop/slides/pulumi-tf-arm) comparing it to Terraform and ARM templates.

## Setup or grab a development machine

In order to follow the workshop on your own machine, you'll need to install [NodeJS](https://nodejs.org/en/) and [VS Code](https://code.visualstudio.com/), clone this repository and follow the instructions you can find in the [scripts folder](scripts/README.md)

If you want to work on a development VM provided for this workshop, please use RDP to connect to one of the machines shown via beamer, and make sure that each of you grabs a separate machine.

After connecting to the VM, run the following script from powershell - it will install some required VS Code extensions and initialize pulumi
> .\scripts\finalize-vm-setup.ps1

## Choose your focus for the workshop

Depending on the knowledge you already bring to this workshop and on your main area of interest, you can choose to be working on different aspects:

- Architecture as Code with structurizr → see [labs](examples/getting-started/structurizr/README.md)
- Infrastructure as Code with pulumi → see [labs](examples/getting-started/pulumi/README.md)
- Combining architecture & infrastructure as code → see [labs](examples/getting-started/pulumi-and-structurizr/README.md)
  - this lab is intended for advanced users that are already comfortable with either structurizr or pulumi