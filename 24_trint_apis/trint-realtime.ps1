#!/usr/bin/env pwsh

<#
.Synopsis
Powershell helper for Trint live 

.Description
A helper for Trint live API 

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
    [Parameter(Mandatory=$false)][switch]$pull=$false,
    [Parameter(Mandatory=$false)][switch]$push=$false,
    [Parameter(Mandatory=$false)][switch]$status=$false,
    [Parameter(Mandatory=$false)][switch]$stop=$false,
    [Parameter(Mandatory=$false)][switch]$export=$false,
    [Parameter(Mandatory=$false)][string]$format="json",
    [Parameter(Mandatory=$false)][string]$trintid="",
    [Parameter(Mandatory=$false)][string]$streamUrl="https://nhkwlive-xjp.akamaized.net/hls/live/2003458/nhkwlive-xjp-en/index_1M.m3u8",
    [Parameter(Mandatory=$false)][string]$title="apitest"
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
# Start a realtime pull 
##############################################################

if ($pull) {
    if ($null -eq $env:TRINT_APIKEY) {
        Write-Host "TRINT_APIKEY is not set"
        return
    }
    if ($null -eq $env:TRINT_BASEAPI) {
        Write-Host "TRINT_BASEAPI is not set"
        return
    }

    $headers=@{}
    $headers.Add("Accept", "application/json")
    $headers.Add("api-key", "$env:TRINT_APIKEY")
    $headers.Add("Content-Type", "application/json")
    $source = $streamUrl
    $body = '{"language":"en","streamUrl":"' + $source + '","transcriptDelay":"5","title":"' + $title + '"}'
    $url = $env:TRINT_BASEAPI + '/transcripts/realtime'
    
    try {
        Write-Host "Starting realtime PULL: $title"
        Write-Host "Invoking '$url' with '$source'"
        $response = Invoke-RestMethod -Method 'PUT' -Uri $url -Headers $headers -Body $body
        $response
    } catch {
        Write-Host "RESPONSE:" $_.Exception.Response
        Write-Host "StatusCode:" $_.Exception.Response.StatusCode.value__ 
        Write-Host "StatusDescription:" $_.Exception.Response.StatusDescription
    }
}

##############################################################
# Start a realtime push
##############################################################

if ($push) {
    if ($null -eq $env:TRINT_APIKEY) {
        Write-Host "TRINT_APIKEY is not set"
        return
    }
    if ($null -eq $env:TRINT_BASEAPI) {
        Write-Host "TRINT_BASEAPI is not set"
        return
    }

    $headers=@{}
    $headers.Add("Accept", "application/json")
    $headers.Add("api-key", "$env:TRINT_APIKEY")
    $headers.Add("Content-Type", "application/json")
    $body = '{"language":"en","transcriptDelay":"5","title":"' + $title + '"}'
    $url = $env:TRINT_BASEAPI + '/transcripts/realtime/push'
    
    try {
        Write-Host "Starting realtime PUSH: $title"
        Write-Host "Invoking '$url'"
        $response = Invoke-RestMethod -Method 'POST' -Uri $url -Headers $headers -Body $body
        $response
    } catch {
        Write-Host "RESPONSE:" $_.Exception.Response
        Write-Host "StatusCode:" $_.Exception.Response.StatusCode.value__ 
        Write-Host "StatusDescription:" $_.Exception.Response.StatusDescription
    }
}

##############################################################
# Status of a realtime
##############################################################

if ($status) {
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
    $url = $env:TRINT_BASEAPI + "/transcripts/realtime/$trintid"
    
    try {
        Write-Host "Status of TrintId: $trintid"
        Write-Host "Invoking '$url'"
        $response = Invoke-RestMethod -Method 'GET' -Uri $url -Headers $headers
        $response
    } catch {
        Write-Host "RESPONSE:" $_.Exception.Response
        Write-Host "StatusCode:" $_.Exception.Response.StatusCode.value__ 
        Write-Host "StatusDescription:" $_.Exception.Response.StatusDescription
    }
}

##############################################################
# Stop a realtime
##############################################################

if ($stop) {
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
    $url = $env:TRINT_BASEAPI + "/transcripts/realtime"
    
    try {
        Write-Host "Stopping TrintId: $trintid"
        Write-Host "Invoking '$url'"
        $body = '{"trintId":"' + $trintid + '"}'
        $response = Invoke-RestMethod -Method 'DELETE' -Uri $url -Headers $headers -Body $body
        $response
    } catch {
        Write-Host "RESPONSE:" $_.Exception.Response
        Write-Host "StatusCode:" $_.Exception.Response.StatusCode.value__ 
        Write-Host "StatusDescription:" $_.Exception.Response.StatusDescription
    }
}

##############################################################
# Export realtime transcription (use -format to get text or json)
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
