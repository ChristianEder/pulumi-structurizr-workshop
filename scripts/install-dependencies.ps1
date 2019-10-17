$packageJsons = Get-ChildItem ..\examples -Recurse -Include package.json | Where-Object { $_.FullName -inotmatch 'node_modules' }
$cwd = Get-Location

foreach ($packageJson in $packageJsons)
{
    $path = $packageJson.PSParentPath
    Set-Location $path
    Start-Process -FilePath "C:\Program Files\nodejs\npm" -ArgumentList "i" -Wait -NoNewWindow
}

Set-Location $cwd.Path