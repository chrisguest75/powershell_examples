#!/usr/bin/env pwsh

<#
.Synopsis
Powershell helper for Trint Batch

.Description
A helper for Trint Transcriptions API 

.Parameter help
Show help

.Parameter help
Show help

.Example

#>
param(
    #[Parameter(Mandatory=$true)][string]$path="",
    [string]$path="",
    [Parameter(Mandatory=$false)][switch]$help=$false,
    [Parameter(Mandatory=$false)][switch]$folder=$false,
    [Parameter(Mandatory=$false)][switch]$upload=$false,
    [Parameter(Mandatory=$false)][switch]$export=$false,
    [Parameter(Mandatory=$false)][string]$format="json",
    [Parameter(Mandatory=$false)][string]$file="",
    [Parameter(Mandatory=$false)][string]$language="en",
    [Parameter(Mandatory=$false)][string]$trintid="",
    [Parameter(Mandatory=$false)][string]$title="uploadtest"
)

#***********************************************************************************************************
#** Usage
#***********************************************************************************************************

$showhelp = $false

if ( $PSBoundParameters.Values.Count -eq 0 -and $args.count -eq 0 ) {
    $showhelp = $true
}

if(($help -eq $true) -or ($showhelp -eq $true)) {
    Get-Help $MyInvocation.MyCommand.Definition -Detailed
    return
}

##############################################################
# Start an upload
##############################################################

# curl --request POST --url https://api.trint.com/folders --header 'Accept: application/json' --header 'Content-Type: application/json' --header "api-key: ${APIKEY}" --data '{"name":"bitrate_mp3"}'

if ($upload) {
    if ($null -eq $env:TRINT_APIKEY) {
        Write-Host "TRINT_APIKEY is not set"
        return
    }
    if ($null -eq $env:TRINT_BASEAPI) {
        Write-Host "TRINT_BASEAPI is not set"
        return
    }

    if (Test-Path $file) {
        $headers=@{}
        $headers.Add("api-key", "$env:TRINT_APIKEY")
        $headers.Add("Content-Type", "video/mp4")
        $url = $env:TRINT_UPLOAD_BASEAPI + "/?filename=${title}&language=${language}"
        #&folder-id=${FOLDERID}
        try {
            Write-Host "Starting upload: $title"
            Write-Host "Invoking '$url' with '$file'"
            $response = Invoke-RestMethod -Method 'POST' -Uri $url -Headers $headers -InFile $file
            $response
        } catch {
            Write-Host "RESPONSE:" $_.Exception.Response
            Write-Host "StatusCode:" $_.Exception.Response.StatusCode.value__ 
            Write-Host "StatusDescription:" $_.Exception.Response.StatusDescription
        }    
    } else {
        Write-Host "File does not exist '$file'" 
    }
}

##############################################################
# Export transcription (use -format to get text or json)
##############################################################

if ($export) {
    if ($null -eq $env:TRINT_APIKEY) {
        Write-Host "TRINT_APIKEY is not set"
        return
    }
    if ($null -eq $env:TRINT_BASEAPI) {
        Write-Host "TRINT_BASEAPI is not set"
        return
    }
    if ($trintid -eq "") {
        Write-Host "trintid is required"
        return
    }

    $headers=@{}
    $headers.Add("Accept", "application/json")
    $headers.Add("api-key", "$env:TRINT_APIKEY")
    $headers.Add("Content-Type", "application/json")
    $url = $env:TRINT_BASEAPI + "/export/$format/$trintid"
    
    try {
        Write-Host "Exporting TrintId: $trintid"
        Write-Host "Invoking '$url'"
        $response = Invoke-RestMethod -Method 'GET' -Uri $url -Headers $headers
        $response
    } catch {
        Write-Host "RESPONSE:" $_.Exception.Response
        Write-Host "StatusCode:" $_.Exception.Response.StatusCode.value__ 
        Write-Host "StatusDescription:" $_.Exception.Response.StatusDescription
    }
}
