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

Get-ECSCapacityProvider

(Get-ECSClusterDetail -Cluster "arn:aws:ecs:us-east-1:accountid:cluster/cluster").Clusters

Get-ECSTaskDefinitionList
(Get-ECSTaskDefinitionDetail -TaskDefinition arn:aws:ecs:us-east-1:accountid:task-definition/definition:44).TaskDefinition

(Get-ECSTaskDetail -Cluster "arn:aws:ecs:us-east-1:accountid:cluster/cluster"  -Task "arn:aws:ecs:us-east-1:accountid:task/containerinstance").Failures

 (Get-ECSContainerInstanceDetail -cluster "arn:aws:ecs:us-east-1:accountid:cluster/cluster"  -ContainerInstance  arn:aws:ecs:us-east-1:accountid:container-instance/containerinstance).Failures


#>
param(
    [Parameter(Mandatory=$false)][switch]$help=$false,
    [Parameter(Mandatory=$false)][switch]$showclusters=$false,
    [Parameter(Mandatory=$false)][switch]$jobs=$false
)

function Show-Clusters() {
    Get-ECSClusterList
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

if ($jobs) {
    if($queue -eq "")
    {
        Write-Host "Queue name is missing (use -queue)"
        return
    }

    Show-Jobs -queue $queue -jobstatus $status
}

