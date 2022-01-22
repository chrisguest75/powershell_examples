#!/usr/bin/env pwsh

<#
.Synopsis
Demonstrate how to setup logging in powershell

.Description
Demonstrate how to setup logging in powershell

.Parameter help
Show help

.Example
./logging-demo.ps1 -log 

#>
param(
    [Parameter(Mandatory=$false)][switch]$help=$false,
    [Parameter(Mandatory=$false)][switch]$log=$false
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

Import-Module PoShLog
# Create new logger
# This is where you customize where, when and how to log
New-Logger |
    Set-MinimumLevel -Value Verbose | # You can change this value later to filter log messages
    # Here you can add as many sinks as you want - see https://github.com/PoShLog/PoShLog/wiki/Sinks for all available sinks
    Add-SinkConsole |   # Tell logger to write log messages to console
    Add-SinkFile -Path './my_awesome.log' | # Tell logger to write log messages into file
    Start-Logger


if ($log) {
    # Test all log levels
    Write-VerboseLog 'Test verbose message'
    Write-DebugLog 'Test debug message'
    Write-InfoLog 'Test info message'
    Write-WarningLog 'Test warning message'
    Write-ErrorLog 'Test error message'
    Write-FatalLog 'Test fatal message'
}

Close-Logger

