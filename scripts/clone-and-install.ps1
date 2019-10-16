$userDir = .\scripts\get-user-dir.ps1

$repoFolder = $userDir + "\repos\pulumi-structurizr-workshop"

& 'C:\Program Files\Git\cmd\git' clone https://github.com/ChristianEder/pulumi-structurizr-workshop.git $repoFolder
cd $repoFolder
cd scripts
.\install-pulumi.ps1
.\install-dependencies.ps1
.\install-vs-code-extensions.ps1
cd ..

$desktop = $userDir + "\Desktop"
$desktopExists = Test-Path $desktopExists
if(-Not $desktopExists){
    New-Item -ItemType Directory -Force -Path $desktop
}

Write-Host "### Creating desktop shortcut to VS Code"
$WScriptShell = New-Object -ComObject WScript.Shell
$Shortcut = $WScriptShell.CreateShortcut($desktop + "\Open Workshop Repository in VS Code.lnk")
$Shortcut.TargetPath = "vscode://file/" + $repoFolder.Replace("\", "/")
$Shortcut.IconLocation = "C:\Program Files\Microsoft VS Code\Code.exe"
$Shortcut.Save()
Write-Host "### Done Creating desktop shortcut to VS Code"

Write-Host "### Creating desktop shortcut to install VS Code extensions"
$WScriptShell = New-Object -ComObject WScript.Shell
$Shortcut = $WScriptShell.CreateShortcut($desktop + "\Install VS Code extensions.lnk")
$Shortcut.TargetPath = $repoFolder + "\scripts\install-vs-code-extensions.ps1"
$Shortcut.IconLocation = "C:\Program Files\Microsoft VS Code\Code.exe"
$Shortcut.Save()
Write-Host "### Done Creating desktop shortcut to install VS Code extensions"