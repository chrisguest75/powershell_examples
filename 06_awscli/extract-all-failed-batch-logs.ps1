#!/usr/bin/env pwsh

<#
.Synopsis
Extracts a set of failed batch logs

.Description
Extracts a set of failed batch logs

.Parameter queue
Name of queue to extract failed jobs from

.Parameter help
Show help

.Example
./extract-all-failed-batch-logs.ps1 -export -queue enterprise-queue

#>
param(
    #[Parameter(Mandatory=$true)][string]$path="",
    [string]$path="",
    [Parameter(Mandatory=$false)][switch]$help=$false,
    [Parameter(Mandatory=$false)][switch]$export=$false,
    [Parameter(Mandatory=$false)][string]$queue=""
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

if ($export) {
    if($queue -eq "")
    {
        Write-Host "Queue name is missing (use -queue)"
        return
    }

    $outDir = "logfiles"
    New-Item -Path "." -Name $outDir -ItemType "directory" -Force

    $jobs = (./extract-failed-batch-logs.ps1 -failedjobs -queue $queue | select-object jobId)

    $jobs | ForEach-Object {
        $streams = (./extract-failed-batch-logs.ps1 -logstreams -jobid $_.jobId)
        $streams.logStreamName | ForEach-Object {
            $streamId = $_
            $file = $streamId.replace("/", "_")
            $outPath = Join-Path $outDir ($file + ".txt")
            Write-Host $outPath
            (./extract-failed-batch-logs.ps1 -logs -streamid $streamId) | out-file $outPath -append -noclobber
        }
    }
}

