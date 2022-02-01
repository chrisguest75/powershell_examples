function Get-AssemblyTypes([string]$assemblyName) {
    $assembly = [System.Reflection.Assembly]::LoadWithPartialName($assemblyName)
    $assembly.GetTypes() | Where-Object {$_.IsClass -and $_.IsPublic}
}