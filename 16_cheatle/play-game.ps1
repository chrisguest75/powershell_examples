#!/usr/bin/env pwsh

<#
.Synopsis

.Description

.Parameter help
Show help

.Example
./play-game.ps1 -play -path ./5letterwordsdoubles.txt 
./play-game.ps1 -play -path ./5letterwordsdoubles.txt -taken "audio"


. ./play-game.ps1      
$words = load-words -path "./5letterwordsdoubles.txt"
first-words -words $words 
next-words -words $words -taken "audio"
next-words -words $words -taken "audihusecky" -position "^r.*"

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

# $showhelp = $false

# if ( $PSBoundParameters.Values.Count -eq 0 ) {
#     $showhelp = $true
# }

# if(($help -eq $true) -or ($showhelp -eq $true))
# {
#     Get-Help $MyInvocation.MyCommand.Definition -Detailed
#     return
# }

function load-words([string]$path) {
    $wordsfile = get-content $path | ConvertFrom-Json

    $contains = @{}

    [char[]]"abcdefghijklmnopqrstuvwxyz" | foreach-object {
        $c=[string]$_

        $selected = ($wordsfile | where-object { $_.letter.PSobject.Properties.name -eq $c })

        $contains.add($c, $selected) 
    }

    $words = [PSCustomObject]@{
        all_words = $wordsfile
        containing_letters = $contains
        }

    return $words 
}

function first-words($words) {
    $words.all_words | where-object { $_.vowels -ge 4 }
}

function next-words { 
    param(
        [Parameter(Mandatory=$true)]$words,
        [Parameter(Mandatory=$true)][string]$taken,
        [Parameter(Mandatory=$false)][string]$position=".*"
    )
    $list = ($words.all_words | where-object { 
        $word = $_
        $valid = $true
        [char[]]"$taken" | foreach-object {
            $c=[string]$_
            if (($word.letter.PSobject.Properties.name -match $c).length -ne 0) {
                $valid = $false
            }
        }
        if ($valid) {
            $word
        }
    })
    $list | where-object { $_.word | select-string -pattern $position } 
}


if ($play) {
    

}


