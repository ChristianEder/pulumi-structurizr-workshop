$vmsJsonStringArray = az vm list-ip-addresses
$vmsJsonString = [string]::Concat($vmsJsonStringArray)
$vms = ConvertFrom-Json -InputObject $vmsJsonString

Write-Host("#################")

foreach ($vm in $vms)
{
    if($vm.virtualMachine.name -inotmatch 'iacaac'){
        continue;
    }
    if($vm.virtualMachine.network.publicIpAddresses.Length -gt 0)
    {
        foreach ($ip in $vm.virtualMachine.network.publicIpAddresses)
        {
            Write-Host($vm.virtualMachine.name + ": " + $ip.ipAddress)
        }
    }
    else
    {
        Write-Host($vm.virtualMachine.name + ": [no public ip yet]")
    }
}

Write-Host("#################")

foreach ($vm in $vms)
{
    if($vm.virtualMachine.name -inotmatch 'iacaac'){
        continue;
    }
    if($vm.virtualMachine.network.publicIpAddresses.Length -gt 0)
    {
        foreach ($ip in $vm.virtualMachine.network.publicIpAddresses)
        {
            $ipJson = ConvertTo-Json -InputObject $ip
            Write-Host("#################")
            Write-Host("### " + $vm.virtualMachine.name)
            Write-Host("### " + $ipJson)
        }
    }
    else
    {
        Write-Host($vm.virtualMachine.name + ": [no public ip yet]")
    }
}