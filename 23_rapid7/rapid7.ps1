#!/usr/bin/env pwsh

<#
.Synopsis

.Description

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
    [Parameter(Mandatory=$false)][switch]$logs=$false,
    [Parameter(Mandatory=$false)][switch]$usage=$false
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

if ($logs) {
    if ($null -eq $env:RAPID7_APIKEY) {
        Write-Host "RAPID7APIKEY is not set"
        return
    }

    $headers = @{
        'x-api-key' = $env:RAPID7_APIKEY
    }
    $url="https://eu.rest.logs.insight.rapid7.com/management/logsets"
    Invoke-RestMethod -Method 'GET' -Uri $url -Headers $headers
}

if ($usage) {
    if ($null -eq $env:RAPID7_APIKEY) {
        Write-Host "RAPID7APIKEY is not set"
        return
    }

    $headers = @{
        'x-api-key' = $env:RAPID7_APIKEY
    }
    $url="https://eu.rest.logs.insight.rapid7.com/usage/organizations/logs?time_range=Last7Days&interval=day"
    Invoke-RestMethod -Method 'GET' -Uri $url -Headers $headers
}

