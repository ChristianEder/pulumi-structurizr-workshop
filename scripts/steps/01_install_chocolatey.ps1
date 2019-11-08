Write-Host("#### 01 - Verifying your chocolatey installation")

try {
    # if chocolatey is already installed, this will just work, otherwise an expection will be thrown, installing choco in the catch block
    $installed = choco -v
    Write-Host("####      chocolatey " + $installed + " is already installed on this system")
    $true
}
catch {
    try {
        Write-Host("####      Installing chocolatey...")
        Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
        $installed = choco -v
        Write-Host("####      Installed chocolatey " + $installed)
        $true
    }
    catch { 
        Write-Host("####      Installing chocolatey failed")
        $false
    }
}