
Set-StrictMode -version 2.0

#load the module methods
@("$PSScriptRoot\*.ps1") | Resolve-Path | Where-Object { -not ($_.ProviderPath.Contains(".Tests.")) } | ForEach-Object { . $_.ProviderPath }
  
#***************************************************************************************************************
#** Exports
#***************************************************************************************************************

export-modulemember -function Get-AppDomainAssemblies
export-modulemember -function Get-UrlEncode
export-modulemember -function Get-AssemblyTypes

#***************************************************************************************************************
