cd c:\
mkdir workshop
cd workshop

Start-Process -FilePath "git" -ArgumentList "clone", "https://github.com/ChristianEder/pulumi-structurizr-workshop.git", -Wait -NoNewWindow

cd "pulumi-structurizr-workshop"

.scripts\setup.ps1
