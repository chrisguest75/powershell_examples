#Dot source all functions in all ps1 files located in the module folder
Write-Host "$PSScriptRoot"
Get-ChildItem -Path $PSScriptRoot/common/*.ps1 -Exclude *.tests.ps1, *profile.ps1 |
ForEach-Object {
    Write-Host "Load " $_.FullName
    . $_.FullName
}

