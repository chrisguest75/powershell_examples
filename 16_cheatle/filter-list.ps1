#!/usr/bin/env pwsh

<#
.Synopsis

.Description

.Parameter help
Show help

.Example
./filter-list.ps1 -create -min 4 -max 8 -path ./words.txt
./filter-list.ps1 -create -min 5 -max 5 -path ./words.txt
(./filter-list.ps1 -filter -min 5 -max 5 -path ./words.txt) | convertto-json | out-file 5letterwords.txt

#>
param(
    [Parameter(Mandatory=$false)][switch]$help=$false,
    [Parameter(Mandatory=$false)][switch]$create=$false,
    [Parameter(Mandatory=$false)][int]$min=5,
    [Parameter(Mandatory=$false)][int]$max=5,
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

if ($create) {
    $wordsfile = get-content $path
    $filtered = ($wordsfile | where { ($_.length -le $max) -and ($_.length -ge $min) })

    $nodoubles = ($filtered | select-string -notmatch "(.)\1") | ForEach-Object { $_.Line }

    [System.Collections.ArrayList]$words = @()
    $noduplicates = ($nodoubles | foreach-object {
        $letter=@{}
        $continue = $true
        $current=$_
        [char[]]"$current" | foreach-object {
            $c=[string]$_
            if ($letter.contains($c)) {
                $continue = $false
            } else {
                $letter.add($c, $true) 
            }
        }
        if ($continue) {
            $vowels = 0
            if ($letter.contains('a')) {
                $vowels=$vowels+1
            }
            if ($letter.contains('e')) {
                $vowels=$vowels+1
            }
            if ($letter.contains('i')) {
                $vowels=$vowels+1
            }
            if ($letter.contains('o')) {
                $vowels=$vowels+1
            }
            if ($letter.contains('u')) {
                $vowels=$vowels+1
            }

            $word = [PSCustomObject]@{
                word = $_
                vowels = $vowels
                letter = $letter
                }
            $word 
        }
    })
    #$noduplicates | format-table -autosize
    #$filtered.length
    #$nodoubles.length
    #$noduplicates.length

    $noduplicates | sort-object vowels 
}
