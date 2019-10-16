Write-Host "### Getting user dir for dev user"
Write-Host("### - Current user is " + $env:UserName)

$userDir ="C:\Users\dev"

if(Test-Path $userDir)
{
    $userDir
}
else
{
    $userDir ="C:\Users\dev" + $env:computername

    if(Test-Path $userDir)
    {
        $userDir
    }
    else
    {
        "not found"
    }
}