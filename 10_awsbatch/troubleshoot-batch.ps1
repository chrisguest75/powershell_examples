#!/usr/bin/env pwsh
#Set-StrictMode -Version Latest

<#
.Synopsis
A set of troubleshooting scripts for dealing with batch

.Description
A set of troubleshooting scripts for dealing with batch

.Parameter showqueues
Show a list of batch queues

.Parameter help
Show help

.Example
./troubleshoot-batch.ps1 -showqueues

#>
param(
    [Parameter(Mandatory=$false)][switch]$help=$false,
    [Parameter(Mandatory=$false)][switch]$showqueues=$false,
    [Parameter(Mandatory=$false)][switch]$jobs=$false,
    [Parameter(Mandatory=$false)][switch]$jobdetails=$false,
    [Parameter(Mandatory=$false)][string]$queue="",
    [Parameter(Mandatory=$false)][string]$status="FAILED",
    [Parameter(Mandatory=$false)][string]$jobid=""
)

function Show-Queues() {
    Get-BATJobQueue | select-object JobQueueName
}

function Show-Jobs([string]$queue="", [string]$jobstatus="FAILED") {
    $filtered = Get-BATJobList -JobQueue $queue -JobStatus $jobstatus
    $filtered | Select-Object -Property status,jobId,jobName,@{
        label='createdAt'
        expression={(Get-Date 01.01.1970)+([System.TimeSpan]::fromseconds( $_.CreatedAt/1000))}
    },@{
        label='reason'
        expression={$_.container.reason}
    },@{
        label='executionTime'
        expression={([System.TimeSpan]::fromseconds( $_.StoppedAt/1000) - ([System.TimeSpan]::fromseconds( $_.StartedAt/1000)))}
    },@{
        label='waitTime'
        expression={([System.TimeSpan]::fromseconds( $_.StartedAt/1000) - ([System.TimeSpan]::fromseconds( $_.CreatedAt/1000)))}
    },@{
        label='id'
        expression={ $_.JobName.substring(25, 22)}
    }
}

function Show-JobDetails([string]$jobid="") {
    Get-BATJobDetail -Job $jobid 
}

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

Import-Module "AWS.Tools.Batch"
Get-AWSCredential
Set-AWSCredential -ProfileName $env:AWS_PROFILE
Get-DefaultAWSRegion 
Set-DefaultAWSRegion -Region $env:AWS_REGION

if ($showqueues) {
    Show-Queues
}

if ($jobs) {
    if($queue -eq "")
    {
        Write-Host "Queue name is missing (use -queue)"
        return
    }

    Show-Jobs -queue $queue -jobstatus $status
}

if ($jobdetails) {
    if($jobid -eq "")
    {
        Write-Host "Jobid is missing (use -jobid)"
        return
    }

    Show-JobDetails -jobid $jobid
}

