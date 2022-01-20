#!/usr/bin/env pwsh

<#
.Synopsis

.Description

.Parameter help
Show help

.Example
 ./play-game.ps1 -play -path ./5letterwords.txt 
./play-game.ps1 -play -path ./5letterwords.txt -taken "audio"

#>
param(
    [Parameter(Mandatory=$false)][switch]$help=$false,
    [Parameter(Mandatory=$false)][switch]$play=$false,
    [Parameter(Mandatory=$false)][string]$taken="",
    [Parameter(Mandatory=$false)][string]$path=""
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

if ($play) {
    $wordsfile = get-content $path | ConvertFrom-Json

    $contains = @{}

    [char[]]"abcdefghijklmnopqrstuvwxyz" | foreach-object {
        $c=[string]$_

        $selected = ($wordsfile | where-object { $_.letter.PSobject.Properties.name -eq $c })

        $contains.add($c, $selected) 
    }
    
    if ($taken -eq "") {
        $wordsfile | where-object { $_.vowels -ge 4 }
    } else {
        $letter=@{}
        [char[]]"$taken" | foreach-object {
            $c=[string]$_
            $letter.add($c, $true) 
        }
        $contains.Key | ForEach-Object {
            if (!$letter.contains([string]$_.Key)) {
                $contains[[string]$_.Key]
            }
        }

    }


    #$contains 



        # if ($continue) {
        #     $vowels = 0
        #     if ($letter.contains('a')) {
        #         $vowels=$vowels+1
        #     }
        #     if ($letter.contains('e')) {
        #         $vowels=$vowels+1
        #     }
        #     if ($letter.contains('i')) {
        #         $vowels=$vowels+1
        #     }
        #     if ($letter.contains('o')) {
        #         $vowels=$vowels+1
        #     }
        #     if ($letter.contains('u')) {
        #         $vowels=$vowels+1
        #     }

        #     $word = [PSCustomObject]@{
        #         word = $_
        #         vowels = $vowels
        #         letter = $letter
        #         }
        #     $word 
}


