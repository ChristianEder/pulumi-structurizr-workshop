Write-Host "### Getting user dir for dev user" 
Write-Host("### - Current user is " + $env:UserName)

$devUser = "C:\Users\dev"
$devUser2 = $devUser + "." + $env:computernamev
$users = $devUser, $devUser2 

foreach($userDir in $users) {
    Write-Host("## Setting up for user dir " + $userDir)

    $userDirExists = Test-Path $userDir
    if(-Not $userDirExists){
        New-Item -ItemType Directory -Force -Path $userDir
    }

    $desktop = $userDir + "\Desktop"
    $desktopExists = Test-Path $desktop
    if(-Not $desktopExists){
        New-Item -ItemType Directory -Force -Path $desktop
    }

    $repoFolder = $userDir + "\repos\pulumi-structurizr-workshop"

    Start-Process -FilePath "C:\Program Files\Git\cmd\git" -ArgumentList "clone", "https://github.com/ChristianEder/pulumi-structurizr-workshop.git", $repoFolder -Wait -NoNewWindow
    cd $repoFolder
    cd scripts
    .\install-pulumi.ps1
    .\install-dependencies.ps1
    .\install-vs-code-extensions.ps1 -userDir $userDir
    cd ..

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
}

