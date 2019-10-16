$username = "dev." + $env:computername

$repoFolder = "C:\Users\" + $username + "\repos\pulumi-structurizr-workshop"

& 'C:\Program Files\Git\cmd\git' clone https://github.com/ChristianEder/pulumi-structurizr-workshop.git $repoFolder
cd $repoFolder
cd scripts
.\install-pulumi.ps1
.\install-dependencies.ps1
.\install-vs-code-extensions.ps1
cd ..

$userDir = .\scripts\get-user-dir.ps1

Write-Host "### Creating desktop shortcut to VS Code"
$WScriptShell = New-Object -ComObject WScript.Shell
$Shortcut = $WScriptShell.CreateShortcut($userDir + "\Desktop\Open Workshop Repository in VS Code.lnk")
$Shortcut.TargetPath = "vscode://file/C:/Users/" + $username + "/repos/pulumi-structurizr-workshop"
$Shortcut.IconLocation = "C:\Program Files\Microsoft VS Code\Code.exe"
$Shortcut.Save()
Write-Host "### Done Creating desktop shortcut to VS Code"

Write-Host "### Creating desktop shortcut to install VS Code extensions"
$WScriptShell = New-Object -ComObject WScript.Shell
$Shortcut = $WScriptShell.CreateShortcut($userDir + "\Desktop\Install VS Code extensions.lnk")
$Shortcut.TargetPath = $repoFolder + "\scripts\install-vs-code-extensions.ps1"
$Shortcut.IconLocation = "C:\Program Files\Microsoft VS Code\Code.exe"
$Shortcut.Save()
Write-Host "### Done Creating desktop shortcut to install VS Code extensions"