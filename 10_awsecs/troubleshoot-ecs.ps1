#!/usr/bin/env pwsh
#Set-StrictMode -Version Latest

<#
.Synopsis
A set of troubleshooting scripts for dealing with ecs

.Description
A set of troubleshooting scripts for dealing with ecs

.Parameter help
Show help

.Example

./troubleshoot-ecs.ps1 -showclusters

./troubleshoot-ecs.ps1 -cluster "arn:aws:ecs:us-east-1:accountid:cluster/cluster" -services

#>
param(
    [Parameter(Mandatory=$false)][switch]$help=$false,
    [Parameter(Mandatory=$false)][switch]$showclusters=$false,
    [Parameter(Mandatory=$false)][string]$cluster="",
    [Parameter(Mandatory=$false)][string]$service="",
    [Parameter(Mandatory=$false)][switch]$services=$false,
    [Parameter(Mandatory=$false)][switch]$tasks=$false
)

function Show-Clusters() {
    Get-ECSClusterList
}

function Show-Tasks($tasks) {
    $tasks | Select-Object -Property @{
        label='CreatedAt'
        expression={ ($_.tasks.createdAt) }
    },
    @{
        label='LastStatus'
        expression={ ($_.tasks.LastStatus) }
    },
    @{
        label='jobDefinition'
        expression={ ($_.tasks.Taskdefinitionarn.split('/')[1]) }
    },
    @{
        label='TaskArn'
        expression={ ($_.tasks.TaskArn) }
    }
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

Import-Module "AWS.Tools.ECS"
#Get-AWSCredential
Set-AWSCredential -ProfileName $env:AWS_PROFILE
#Get-DefaultAWSRegion 
Set-DefaultAWSRegion -Region $env:AWS_REGION

if ($showclusters) {
    Show-Clusters
}

if ($services) {
    if($cluster -eq "")
    {
        Write-Host "Cluster name is missing (use -cluster)"
        return
    }

    Get-ECSClusterService -cluster $cluster
}

if ($tasks) {
    if($cluster -eq "")
    {
        Write-Host "Cluster name is missing (use -cluster)"
        return
    }

    $alltasks=(Get-ECSTasks -cluster $cluster | ForEach-Object {Get-ECSTaskDetail -cluster $cluster -task $_ })
    Show-Tasks $alltasks | sort-object -Property jobDefinition,createdAt,LastStatus -Descending 
}
