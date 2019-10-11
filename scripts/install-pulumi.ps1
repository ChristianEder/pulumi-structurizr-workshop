[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; iex ((New-Object System.Net.WebClient).DownloadString('https://get.pulumi.com/install.ps1'))
[System.Environment]::SetEnvironmentVariable("PATH", $Env:Path + ";" + $Env:USERPROFILE + "\.pulumi\bin", [System.EnvironmentVariableTarget]::User)

$pulumiBin = "C:\windows\system32\config\systemprofile\.pulumi\bin"
$currentPath = [System.Environment]::GetEnvironmentVariable("PATH", [System.EnvironmentVariableTarget]::Machine)
[System.Environment]::SetEnvironmentVariable("PATH", $currentPath + ";" + $pulumiBin, [System.EnvironmentVariableTarget]::Machine)

& 'C:\windows\system32\config\systemprofile\.pulumi\bin\pulumi' login --local