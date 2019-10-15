$username = "dev." + $env:computername

$repoFolder = "C:\Users\" + $username + "\repos\pulumi-structurizr-workshop"

& 'C:\Program Files\Git\cmd\git' clone https://github.com/ChristianEder/pulumi-structurizr-workshop.git $repoFolder
cd $repoFolder
cd scripts
.\install-pulumi.ps1
.\install-dependencies.ps1
.\install-vs-code-extensions.ps1
cd ..


$WScriptShell = New-Object -ComObject WScript.Shell
$Shortcut = $WScriptShell.CreateShortcut("C:\Users\" +  $username + "\Desktop\Open Workshop Repository in VS Code.lnk")
$Shortcut.TargetPath = "vscode://file/C:/Users/" + $username + "/repos/pulumi-structurizr-workshop"
$Shortcut.IconLocation = "C:\Program Files\Microsoft VS Code\Code.exe"
$Shortcut.Save()