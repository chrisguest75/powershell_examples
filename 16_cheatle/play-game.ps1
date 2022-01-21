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
$first = first-words -words $words 
$first
calculate_ratios -words $words -selected $first | sort-object WordCount

$next = next-words -words $words -taken "oue" -contains "ri"
calculate_ratios -words $words -selected $next | sort-object WordCount

$next = next-words -words $words -taken "ouelas" -contains "ri"
calculate_ratios -words $words -selected $next | sort-object WordCount

$next = next-words -words $words -taken "ouelasnt" -position "pri.*" -contains "pri"
calculate_ratios -words $words -selected $next | sort-object WordCount

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

function calculate_ratios {
    param(
        [Parameter(Mandatory=$true)]$words,
        [Parameter(Mandatory=$true)]$selected
    )

    $selected | foreach-object {
        $word = $_
        $wordcount = 0 
        $word.letter.PSobject.Properties.name | foreach-object {
            $c=[string]$_

            $wordcount += [int]$words.containing_letters[$c].Count 
        } 
        add-member -inputobject $word -membertype NoteProperty -Name "WordCount" -Value $wordcount -Force
        $word
    }

}
function first-words($words) {
    $words.all_words | where-object { $_.vowels -ge 4 }
}

function next-words { 
    param(
        [Parameter(Mandatory=$true)]$words,
        [Parameter(Mandatory=$true)][string]$taken,
        [Parameter(Mandatory=$true)][string]$contains,
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
            $found=$true
            [char[]]"$contains" | foreach-object {
                $c=[string]$_
                if (($word.letter.PSobject.Properties.name -match $c).length -eq 0) {
                    $found = $false
                }
            }
            if ($found) {
                $word
            }
        }
    })
    $list | where-object { $_.word | select-string -pattern $position } 
}


if ($play) {
    

}


