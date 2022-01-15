#!/usr/bin/env pwsh

<#
.Synopsis

.Description

.Parameter help
Show help

.Example

#>
param(
    [Parameter(Mandatory=$false)][switch]$help=$false,
    [Parameter(Mandatory=$false)][switch]$generate=$false,
    [Parameter(Mandatory=$false)][string]$queue=""
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

if ($generate) {
    $jobs = (./extract-failed-batch-logs.ps1 -failedjobs -queue $queue) | select jobId 

    $jobs | % {
        $job=(./detail-job.ps1 -jobid $_.jobId) | select-object jobName,parameters,jobDefinition

        $param1=$job.parameters.param1
        $line = "aws --profile $env:AWS_PROFILE --region $env:AWS_REGION batch submit-job --job-name """ + $job.jobName + """ --job-queue $queue --parameters param1=$param1 --job-definition """ + $job.jobDefinition + """"
        $line
    } | % { $_ | out-file ./resubmit.sh -Append -NoClobber}
}
