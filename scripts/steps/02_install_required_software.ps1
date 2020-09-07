Write-Host("#### 02 - Installing required software")

try {
    Write-Host("####     02.01 - Installing NodeJS")
    choco install nodejs.install -y
    $version = node --version
    Write-Host("####         Installed NodeJS " + $version)
    Start-Sleep -Seconds 2

    Write-Host("####     02.02 - Installing .NET Core SDK")
    choco install dotnetcore-sdk -y
    $version = dotnet --version
    Write-Host("####         Installed .NET Core " + $version)
    Start-Sleep -Seconds 2

    Write-Host("####     02.03 - Installing VS Code")
    choco install vscode -y
    $version = code --version
    Write-Host("####         Installed VS Code " + $version[0])
    Start-Sleep -Seconds 2
    
    Write-Host("####     02.04 - Installing PlantUML")
    choco install plantuml -y
    Write-Host("####         Installed PlantUML")
    Start-Sleep -Seconds 2
    
    Write-Host("####     02.05 - Installing GraphViz")
    choco install graphviz -y
    Write-Host("####         Installed GraphViz")
    Start-Sleep -Seconds 2
    
    Write-Host("####     02.06 - Installing Azure CLI")
    choco install azure-cli -y
    $version = az --version
    Write-Host("####         Installed Azure CLI " + $version[0])
    Start-Sleep -Seconds 2
    
    Write-Host("####     02.07 - Installing Pulumi")
    choco install pulumi -y
    $version = pulumi version
    Write-Host("####         Installed Pulumi " + $version)
    pulumi logout --non-interactive
    pulumi login --local

    Write-Host("####     Installed all required software")
}
catch {
    Write-Host("####     Installing required software failed")
    $false
}