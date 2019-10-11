$packageJsons = Get-ChildItem ..\examples -Recurse -Include package.json | Where-Object { $_.FullName -inotmatch 'node_modules' }
$cwd = Get-Location

foreach ($packageJson in $packageJsons)
{
    $path = $packageJson.PSParentPath
    Set-Location $path
    npm i
}

Set-Location $cwd.Path