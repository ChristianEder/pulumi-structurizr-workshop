$repoFolder = "C:\repos\pulumi-structurizr-workshop"

Start-Process -FilePath "C:\Program Files\Git\cmd\git" -ArgumentList "clone", "https://github.com/ChristianEder/pulumi-structurizr-workshop.git", $repoFolder -Wait -NoNewWindow

cd $repoFolder
cd scripts
.\install-pulumi.ps1
.\install-dependencies.ps1
cd ..
