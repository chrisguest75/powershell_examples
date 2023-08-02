#!/usr/bin/env pwsh
#Set-StrictMode -Version Latest

<#
.Synopsis
A script for checking compliance of S3 buckets

.Description
A script for checking compliance of S3 buckets

.Parameter help
Show help

.Example


#>
param(
    [Parameter(Mandatory=$false)][switch]$help=$false,
    [Parameter(Mandatory=$false)][string]$environment="dev",
    [Parameter(Mandatory=$false)][switch]$export=$false
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

Write-Host "Loading $PSScriptRoot/config.json with $environment"
$config = get-content $PSScriptRoot/config.json | ConvertFrom-Json

$env:ENVIRONMENT_NAME=$environment
$env:AWS_REGION=$config.$environment.region
if ($config.$environment.profile -ne "default") {
    $env:AWS_PROFILE=$config.$environment.profile
} else {
    $env:AWS_PROFILE=""
}
$env:AWS_ACCOUNTID=$config.$environment.accountid

if ($config.$environment.profile -ne "default") {
    if ($null -eq $env:AWS_PROFILE) {
        Write-Host "AWS_PROFILE is not set"
        return
    }
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

# TODO: Policies, Public Access, Encryption, Versioning, creation date, file count??, size, etc.

$buckets = Get-S3Bucket

# gather data 
$sizes = $buckets | ForEach-Object -Begin {
    # Set the $i counter variable to zero.
    $i = 0
} -Process {
    $bucket = $_
    $metric = New-Object System.Object
    Add-Member -inputobject $metric -membertype NoteProperty -Name "Name" -Value $bucket.BucketName

    $bucketName = $bucket.BucketName
    $storageType = "StandardStorage" # or another storage type as needed

    $endTime = (Get-Date)
    $startTime = $endTime.AddDays(-10)

    $datapoints = Get-CWMetricStatistics -Namespace AWS/S3 -MetricName BucketSizeBytes -UtcStartTime $startTime -UtcEndTime $endTime -Period 86400 -Statistics Average -Dimensions @(@{Name="BucketName";Value=$bucketName},@{Name="StorageType";Value=$storageType})
    Add-Member -inputobject $metric -membertype NoteProperty -Name "SizeInBytes" -Value ([int64]($datapoints.Datapoints[-1].Average)).ToString()

    $datapoints  = Get-CWMetricStatistics -Namespace AWS/S3 -MetricName NumberOfObjects -UtcStartTime $startTime -UtcEndTime $endTime -Period 86400 -Statistics Average -Dimensions @(@{Name="BucketName";Value=$bucketName},@{Name="StorageType";Value="AllStorageTypes"})
    Add-Member -inputobject $metric -membertype NoteProperty -Name "NumberOfObjects" -Value ([int64]($datapoints.Datapoints[-1].Average)).ToString()

    # Increment the $i counter variable which is used to create the progress bar.
    $i = $i+1
    # Determine the completion percentage (2 decimal places)
    $Completed = "{0:N2}" -f (($i/$buckets.count) * 100) 
    # Use Write-Progress to output a progress bar.

    Write-Progress -Activity "Progress" -Status "$Completed% Complete:" -PercentComplete $Completed
    
    $metric
} -End {
# Display the matching messages using the out variable.
#$out
}

$sizes | Format-Table -AutoSize



