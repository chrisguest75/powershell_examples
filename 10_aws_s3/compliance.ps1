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
$outbuckets = $buckets | ForEach-Object -Begin {
    # Set the $i counter variable to zero.
    $i = 0
    # Set the $out variable to a empty string.
    $out = @()
} -Process {
    $bucket = $_
    # tags
    $tagging = ""
    try {
        $tagging = Get-S3BucketTagging -BucketName $bucket.BucketName
        if ($tagging -eq $null) {
            $tagging = ""
        } else {
            $tags = $tagging | ConvertTo-Csv -NoTypeInformation -Delimiter "=" -UseQuotes AsNeeded | select-object -skip 1 
            $tagging = $tags -join ","
        }
    } catch {
        Write-Host "Get-S3BucketTagging ERROR:" $bucket.BucketName $_.Exception
    }     
    Add-Member -inputobject $bucket -membertype NoteProperty -Name "Tags" -Value $tagging -Force
    
    # logging
    $loggingPath = ""
    try {
        $logging = Get-S3BucketLogging -BucketName $bucket.BucketName
        $loggingPath = ""
        if ($logging.TargetBucketName -ne $null) {
            $loggingPath = ("s3://" + $logging.TargetBucketName + "/" + $logging.TargetPrefix)
        }
    } catch {
        Write-Host "Get-S3BucketLogging ERROR:" $bucket.BucketName $_.Exception
    }     
    Add-Member -inputobject $bucket -membertype NoteProperty -Name "Logging" -Value $loggingPath -Force

    # public
    $ispublic = "N/A"
    try {
        $ispublic = (Get-S3BucketPolicyStatus -BucketName $bucket.BucketName).IsPublic
    } catch {
        Write-Host "Get-S3BucketPolicyStatus ERROR:" $bucket.BucketName
        #Write-Host "Get-S3BucketPolicyStatus ERROR:" $bucket.BucketName $_.Exception
    }     
    Add-Member -inputobject $bucket -membertype NoteProperty -Name "Public" -Value $ispublic -Force

    # lifecycle policy 
    $lifecycleName = "N/A"
    try {
        $lifecycleName = (Get-S3LifecycleConfiguration -BucketName $bucket.BucketName).Rules.Id
    } catch {
        Write-Host "Get-S3LifecycleConfiguration ERROR:" $bucket.BucketName
        #Write-Host "Get-S3BucketPolicyStatus ERROR:" $bucket.BucketName $_.Exception
    }     
    Add-Member -inputobject $bucket -membertype NoteProperty -Name "Lifecycle" -Value $lifecycleName -Force


    $bucket | Select-Object BucketName,Logging,Tags,Public,Lifecycle,CreationDate

    #$out += $bucket
    # Increment the $i counter variable which is used to create the progress bar.
    $i = $i+1
    # Determine the completion percentage (2 decimal places)
    $Completed = "{0:N2}" -f (($i/$buckets.count) * 100) 
    # Use Write-Progress to output a progress bar.

    Write-Progress -Activity "Progress" -Status "$Completed% Complete:" -PercentComplete $Completed

} -End {
    # Display the matching messages using the out variable.
    #$out
}

$outbuckets | sort-object Public | Format-Table -Property @{ e='BucketName'; width = 60 },@{ e='Public'; width = 6 },@{ e='Logging'; width = 80 },@{ e='Lifecycle'; width = 30 },@{ e='CreationDate'; width = 15 },@{ e='Tags'; width = 80 }

$outPath = "$PSScriptRoot/output"
$outFile = "$outPath/$environment-buckets.csv"
$folder = New-Item -ItemType Directory -Force -Path $outPath
Write-Host "Writing: $outFile"
$outbuckets | Export-CSV -NoTypeInformation -Delimiter "," -UseQuotes AsNeeded -Path $outFile

# TODO: apply policies to it.  
