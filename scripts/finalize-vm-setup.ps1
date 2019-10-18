$userDir = "C:\Users\" + $env:username
$repoFolder = "C:\repos\pulumi-structurizr-workshop"

$installVsCodeExtensions = $repoFolder + "\scripts\install-vs-code-extensions.ps1"

& $installVsCodeExtensions -userDir $userDir

Start-Process -FilePath "C:\windows\system32\config\systemprofile\.pulumi\bin\pulumi" -ArgumentList "logout", "--non-interactive" -Wait -NoNewWindow
Start-Process -FilePath "C:\windows\system32\config\systemprofile\.pulumi\bin\pulumi" -ArgumentList "login", "--local" -Wait -NoNewWindow