Write-Host "### Installing VS Code extensions"
$userDir = .\get-user-dir.ps1
$extensionDir = $userDir + "\.vscode\extensions"
$code = "C:\Program Files\Microsoft VS Code\bin\code.cmd"

function Install-VS-Code-Extension($name) {
    Write-Host("### - Installing " + $name)

    $pinfo = New-Object System.Diagnostics.ProcessStartInfo
    $pinfo.FileName = $code
    $pinfo.RedirectStandardError = $true
    $pinfo.RedirectStandardOutput = $true
    $pinfo.UseShellExecute = $false
    $pinfo.Arguments = "--install-extension " + $name + " --force --extensions-dir " + $extensionDir
    $p = New-Object System.Diagnostics.Process
    $p.StartInfo = $pinfo
    $p.Start() | Out-Null
    $p.WaitForExit(60000) | Out-Null
    $stdout = $p.StandardOutput.ReadToEnd()

    Write-Host("###  - Got output: " + $stdout)

    if ($p.ExitCode -eq 0) {
        Write-Host("###  - Installed " + $name + " successfully")
    }
    else {
        $stderr = $p.StandardError.ReadToEnd()
        Write-Host("###  - Got error: " + $stderr)
        Write-Host("###  - Error installing " + $name + "; ExitCode: " + $p.ExitCode)
    }
}

Install-VS-Code-Extension "yzhang.markdown-all-in-one"
Install-VS-Code-Extension "jebbs.plantuml"
Install-VS-Code-Extension "mauve.terraform"
Install-VS-Code-Extension "ms-vscode.powershell"

Write-Host "### Done Installing VS Code extensions"