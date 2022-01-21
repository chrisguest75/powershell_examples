#!/usr/bin/env pwsh

<#
.Synopsis


.Description


.Parameter jobid


.Parameter help
Show help

.Example

#>
param(
    [Parameter(Mandatory=$false)][switch]$help=$false,
    [Parameter(Mandatory=$false)][string]$cluster="",
    [Parameter(Mandatory=$false)][string]$instance=""
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

if($cluster -eq "")
{
    Write-Host "cluster name is missing (use cluster)"
    return
}

if($instance -eq "")
{
    Write-Host "instance name is missing (use instance)"
    return
}
$details = (aws --profile (Get-ChildItem -Path Env:\AWS_PROFILE).value --region (Get-ChildItem -Path Env:\AWS_REGION).value ecs describe-container-instances --cluster $cluster --container-instances $instance --include CONTAINER_INSTANCE_HEALTH  | ConvertFrom-Json)

return $details
