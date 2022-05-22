#!/usr/bin/env pwsh

<#
.Synopsis
Powershell code to demonstrate using custom modules

.Description
Powershell code to demonstrate using custom modules

.Parameter help
Show help

.Parameter help
Show help

.Example

#>
param(
    #[Parameter(Mandatory=$true)][string]$path="",
    [string]$path="",
    [Parameter(Mandatory=$false)][switch]$help=$false,
    [Parameter(Mandatory=$false)][switch]$import=$false
)

#***********************************************************************************************************
#** Usage
#***********************************************************************************************************

$showhelp = $false

if ( $PSBoundParameters.Values.Count -eq 0 -and $args.count -eq 0 ) {
    $showhelp = $true
}

if(($help -eq $true) -or ($showhelp -eq $true)) {
    Get-Help $MyInvocation.MyCommand.Definition -Detailed
    return
}

##############################################################
# Import
##############################################################

if ($import) {

}

