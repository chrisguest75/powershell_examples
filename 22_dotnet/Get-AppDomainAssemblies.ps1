
function Get-AppDomainAssemblies() {
    [System.AppDomain]::CurrentDomain.GetAssemblies() | ForEach-Object { $_.GetName().FullName } | Sort-Object
}


