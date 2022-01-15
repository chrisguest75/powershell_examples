#!/usr/bin/env pwsh

<#
.Synopsis
Show the batch queues for an account and region

.Description
Show the batch queues for an account and region

.Parameter help
Show help

.Example
./show-queues.ps1 -showqueues

#>
param(
    [Parameter(Mandatory=$false)][switch]$help=$false,
    [Parameter(Mandatory=$false)][switch]$showqueues=$false
)

#***********************************************************************************************************
#** Usage
#***********************************************************************************************************

$showhelp = $false

if ( $PSBoundParameters.Values.Count -eq 0 ) {
    $showhelp = $true
}

if(($help -eq $true) -or ($showhelp -eq $true))
{
    Get-Help $MyInvocation.MyCommand.Definition -Detailed
    return
}

if ($null -eq $env:AWS_PROFILE) {
    Write-Host "AWS_PROFILE is not set"
    return
}
if ($null -eq $env:AWS_REGION) {
    Write-Host "AWS_REGION is not set"
    return
}

if ($showqueues) {
    $queues = (aws --profile (Get-ChildItem -Path Env:\AWS_PROFILE).value --region (Get-ChildItem -Path Env:\AWS_REGION).value batch describe-job-queues | convertfrom-json)
    return $queues.jobQueues | select-object jobQueueName
}
