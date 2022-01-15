#!/usr/bin/env pwsh

<#
.Synopsis
Print out full job details given id

.Description
Print out full job details given id (use ./find-job.ps1)

.Parameter jobid
The id of the job

.Parameter help
Show help

.Example
./find-job.ps1 find -queue enterprise-queue

#>
param(
    #[Parameter(Mandatory=$true)][string]$path="",
    [string]$path="",
    [Parameter(Mandatory=$false)][switch]$help=$false,
    [Parameter(Mandatory=$false)][string]$jobid=""
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

if ($null -eq $env:AWS_PROFILE) {
    Write-Host "AWS_PROFILE is not set"
    return
}
if ($null -eq $env:AWS_REGION) {
    Write-Host "AWS_REGION is not set"
    return
}

if($jobid -eq "")
{
    Write-Host "jobid name is missing (use jobid)"
    return
}
$job = (aws --profile (Get-ChildItem -Path Env:\AWS_PROFILE).value --region (Get-ChildItem -Path Env:\AWS_REGION).value batch describe-jobs --jobs $jobid | ConvertFrom-Json)

return $job.jobs
