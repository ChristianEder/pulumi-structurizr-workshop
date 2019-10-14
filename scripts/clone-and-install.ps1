& 'C:\Program Files\Git\cmd\git' clone https://github.com/ChristianEder/pulumi-structurizr-workshop.git C:\Users\dev\repos\pulumi-structurizr-workshop
cd C:\Users\dev\repos\pulumi-structurizr-workshop\scripts
.\install-pulumi.ps1
.\install-dependencies.ps1
.\install-vs-code-extensions.ps1
cd ..

$WScriptShell = New-Object -ComObject WScript.Shell
$Shortcut = $WScriptShell.CreateShortcut("C:\Users\dev\Desktop\Open Workshop Repository in VS Code.lnk")
$Shortcut.TargetPath = "vscode://file/C:/Users/dev/repos/pulumi-structurizr-workshop"
$Shortcut.IconLocation = "C:\Program Files\Microsoft VS Code\Code.exe"
$Shortcut.Save()