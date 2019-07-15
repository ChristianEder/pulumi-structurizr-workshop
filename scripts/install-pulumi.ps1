[System.Environment]::SetEnvironmentVariable("PATH", $Env:Path + ";" + $Env:USERPROFILE + "\.pulumi\bin", [System.EnvironmentVariableTarget]::User)
