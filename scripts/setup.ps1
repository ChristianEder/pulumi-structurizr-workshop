$success = .\scripts\steps\01_install_chocolatey.ps1
if(-Not $success){    
    return
}

$success = .\scripts\steps\02_install_required_software.ps1
if(-Not $success){    
    return
}

$success = .\scripts\steps\03_install_vs_code_extensions.ps1
if(-Not $success){    
    return
}

$success = .\scripts\steps\04_install_npm_packages.ps1
if(-Not $success){    
    return
}