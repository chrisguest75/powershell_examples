#!/usr/bin/env pwsh

<#
.Synopsis
Calculates the size of a folder

.Description
Calculates the size of a folder 

.Parameter path
Calculate the size of this path

.Parameter help
Show help

.Example
./calculate-folder-size.ps1 -path ./folders

#>
param(
    #[Parameter(Mandatory=$true)][string]$path="",
    [string]$path="",
    [Parameter(Mandatory=$false)][switch]$help=$false
)

#***********************************************************************************************************
#** Usage
#***********************************************************************************************************

$showhelp = $false

if ( $PSBoundParameters.Values.Count -eq 0 -and $args.count -eq 0 ) {
    $showhelp = $true
}

if(($help -eq $true) -or ($showhelp -eq $true))
{
    Get-Help $MyInvocation.MyCommand.Definition -Detailed
    return
}

Get-ChildItem -Path $path


