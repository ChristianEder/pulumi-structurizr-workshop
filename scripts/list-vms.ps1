
function Parse-AZ($result) {
    $json = [string]::Concat($result)
    ConvertFrom-Json -InputObject $json
}

$vmsJsonStringArray = az vm list-ip-addresses
$vms = Parse-AZ($vmsJsonStringArray)
$vms = $vms | Where-Object { $_.virtualMachine.name -imatch 'iacaac' }
$rg = $vms[0].virtualMachine.resourceGroup

$natRulesJsonArray = az network lb inbound-nat-rule list --lb-name $rg -g $rg
$natRules = Parse-AZ($natRulesJsonArray)

$publicIpsJsonArray = az network public-ip list -g $rg
$publicIps = Parse-AZ($publicIpsJsonArray)

if ($publicIps.Length -eq 1) {
    
    $ip = $publicIps[0].ipAddress

    foreach ($vm in $vms) {
        if ($vm.virtualMachine.name -inotmatch 'iacaac') {
            continue;
        }

        $nat = $natRules | Where-Object { $_.backendIpConfiguration.id -imatch $vm.virtualMachine.name }

        if ($nat -eq $null) {
            Write-Host($vm.virtualMachine.name + ": [no public ip yet]")
        }
        else {
            Write-Host($vm.virtualMachine.name + ": RDP " + $ip + ":" + $nat.frontendPort)
        }
    }
}
else {
    Write-Host("Resourcegroup " + $rg + " contains more than 1 public IP adress, I am not programmed to work with this :-)")
}
