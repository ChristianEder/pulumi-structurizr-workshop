Write-Host("#### 03 - Installing VS Code extensions")

function Install-VS-Code-Extension($name) {
    Write-Host("###     Installing " + $name)

    $pinfo = New-Object System.Diagnostics.ProcessStartInfo
    $pinfo.FileName = "code.cmd"
    $pinfo.RedirectStandardError = $true
    $pinfo.RedirectStandardOutput = $true
    $pinfo.UseShellExecute = $false
    $pinfo.Arguments = "--install-extension " + $name + " --force"
    $p = New-Object System.Diagnostics.Process
    $p.StartInfo = $pinfo
    $p.Start() | Out-Null
    $p.WaitForExit(60000) | Out-Null
    $stdout = $p.StandardOutput.ReadToEnd()

    if ($p.ExitCode -eq 0) {
        Write-Host("####          Installed " + $name + " successfully")
        $true
    }
    else {
        $stderr = $p.StandardError.ReadToEnd()
        Write-Host("####          Error installing " + $name + "; ExitCode: " + $p.ExitCode)
        $false
    }
}

$sucess1 = Install-VS-Code-Extension "yzhang.markdown-all-in-one"
$sucess2 = Install-VS-Code-Extension "jebbs.plantuml"
$sucess3 = Install-VS-Code-Extension "mauve.terraform"
$sucess4 = Install-VS-Code-Extension "ms-vscode.powershell"


$sucess = $sucess1 -and $sucess2 -and $sucess3 -and $sucess4

if($sucess){
    Write-Host("####     Installed VS Code extensions")
}else{
    Write-Host("####     Error installing VS Code extensions")
}
$sucess