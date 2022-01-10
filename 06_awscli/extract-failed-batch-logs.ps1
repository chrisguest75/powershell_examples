#!/usr/bin/env pwsh

<#
.Synopsis
Extracts a set of batch logs

.Description
Extracts a set of batch logs

.Parameter showqueues
Show a list of batch queues

.Parameter failedjobs
Show a list of failed jobs for a queue (requires queue parameter)

.Parameter logstreams
Show a logstreams for a jobid 

.Parameter logs
Get logs from a logstream

.Parameter queue
Name of queue to scan (retrieve from showqueues)

.Parameter jobid
Jobid 

.Parameter streamid
Streamid 

.Parameter help
Show help

.Example
$logs = (./extract-failed-batch-logs.ps1 -logs -streamid "service/default/9378a9a4000000da8a84b7d224c8bac9") 

#>
param(
    #[Parameter(Mandatory=$true)][string]$path="",
    [string]$path="",
    [Parameter(Mandatory=$false)][switch]$help=$false,
    [Parameter(Mandatory=$false)][switch]$showqueues=$false,
    [Parameter(Mandatory=$false)][switch]$failedjobs=$false,
    [Parameter(Mandatory=$false)][switch]$logstreams=$false,
    [Parameter(Mandatory=$false)][switch]$logs=$false,
    [Parameter(Mandatory=$false)][string]$queue="",
    [Parameter(Mandatory=$false)][string]$jobid="",
    [Parameter(Mandatory=$false)][string]$streamid=""
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

if ($showqueues) {
    $queues = (aws --profile (Get-ChildItem -Path Env:\AWS_PROFILE).value --region (Get-ChildItem -Path Env:\AWS_REGION).value batch describe-job-queues | convertfrom-json)
    return $queues.jobQueues | select-object jobQueueName
}

if ($failedjobs) {
    if($queue -eq "")
    {
        Write-Host "Queue name is missing (use -queue)"
        return
    }
    
    # get jobs as an array of objects
    $failed = (aws --profile (Get-ChildItem -Path Env:\AWS_PROFILE).value --region (Get-ChildItem -Path Env:\AWS_REGION).value batch list-jobs --job-queue $queue --job-status FAILED | ConvertFrom-Json)
    #$failed.jobSummaryList

    # filter fields we don't need and convert createdAt timestamp to string. 
    $failedfiltered = $failed.jobSummaryList | Select-Object -Property status,jobId,jobName,@{
        label='createdAt'
        expression={(Get-Date 01.01.1970)+([System.TimeSpan]::fromseconds( $_.createdAt/1000))}
    },@{
        label='reason'
        expression={$_.container.reason}}
    return $failedfiltered
}

if ($logstreams) {
    if($jobid -eq "")
    {
        Write-Host "jobid name is missing (use jobid)"
        return
    }
    $job = (aws --profile (Get-ChildItem -Path Env:\AWS_PROFILE).value --region (Get-ChildItem -Path Env:\AWS_REGION).value batch describe-jobs --jobs $jobid | ConvertFrom-Json)
    $attempts = $job.jobs | % {$_ | select-object -Property jobId,attempts}
    $streams = $attempts | % {$_ | select-object -Property  @{
      label='logStreamName'
      expression={$_.attempts.container.logStreamName}}}
    
    return $streams
}

if ($logs) {
    if($streamid -eq "")
    {
        Write-Host "streamid name is missing (use streamid)"
        return
    }

    $events = (aws --profile (Get-ChildItem -Path Env:\AWS_PROFILE).value --region  (Get-ChildItem -Path Env:\AWS_REGION).value logs get-log-events --log-group-name "/aws/batch/job" --log-stream-name $streamid | convertfrom-json)
    return $events.events
}

