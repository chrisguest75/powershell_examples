#!/usr/bin/env pwsh
#Set-StrictMode -Version Latest

<#
.Synopsis
Set the environment for other scripts

.Description
Set the environment for other scripts

.Parameter help
Show help

.Example

#>
param(
    [Parameter(Mandatory=$false)][switch]$help=$false,
    [Parameter(Mandatory=$false)][string]$environment="dev"
)

# load json
Write-Host "Loading $PSScriptRoot/config.json with $environment"
$config = get-content $PSScriptRoot/config.json | ConvertFrom-Json

$env:ENVIRONMENT_NAME=$environment
$env:AWS_REGION=$config.$environment.region
$env:AWS_PROFILE=$config.$environment.profile
$env:AWS_ACCOUNTID=$config.$environment.accountid

if ($null -eq $env:AWS_PROFILE) {
    Write-Host "AWS_PROFILE is not set"
    return
}
if ($null -eq $env:AWS_REGION) {
    Write-Host "AWS_REGION is not set"
    return
}

#Get-AWSCredential
Set-AWSCredential -ProfileName $env:AWS_PROFILE
#Get-DefaultAWSRegion 
Set-DefaultAWSRegion -Region $env:AWS_REGION
Write-Host "Configured: $env:AWS_PROFILE - $env:AWS_REGION"