Write-Host "### Getting user dir for dev user" 
Write-Host("### - Current user is " + $env:UserName)

$userDir ="C:\Users\dev"
$desktop = $userDir + "\Desktop"

if(Test-Path $desktop)
{
    Write-Host("### - Using " + $userDir)
    $userDir
}
else
{
    $userDir ="C:\Users\dev" + $env:computernamev
    $desktop = $userDir + "\Desktop"

    if(Test-Path $desktop)
    {
        Write-Host("### - Using " + $userDir)
        $userDir
    }
    else
    {
        Write-Host("### - No user dir found")
        "not found"
    }
}