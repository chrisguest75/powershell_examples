#!/usr/bin/env pwsh

<#
.Synopsis

.Description

.Parameter help
Show help

.Example

#>
param(
    [Parameter(Mandatory=$false)][switch]$help=$false,
    [Parameter(Mandatory=$false)][switch]$generate=$false,
    [Parameter(Mandatory=$false)][string]$basepath,
    [Parameter(Mandatory=$false)][string]$output

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

$modes = @("standard", "enhanced")

$basepath="/Users/chris.guest/Code/scratch/ffmpeg_examples/"
$outputpath = "./out"
$files = @("sources/audiobooks/christmas_short_works_2008_0812_64kb_mp3/english_chrismusisacomin_dunbar_jf_64kb.mp3", "sources/audiobooks/christmas_short_works_2008_0812_64kb_mp3/english_thechristmaspresent_crompton_vg_64kb.mp3")
$newfile = "english_chrismusisacomin_dunbar_jf_64kb"
$samplerates = @("22000", "16000", "12000", "8000", "4000")
$bitrates = @("64000", "32000", "16000")
$codecs = @("m4a", "mp3", "flac")

function Create-ConversionScript {
    write-output "set -euf -o pipefail"
    write-output "mkdir -p ""$outputpath"""
    
    foreach ($file in $files) {
        $audio_file = Join-Path $basepath $file
        $output = Join-Path $outputpath ($newfile + ".json")
        ffprobe -v error -show_format -show_streams -print_format json $audio_file | jq . > $output
    
        foreach ($samplerate in $samplerates) {
            foreach ($bitrate in $bitrates) {
                foreach ($codec in $codecs) {
                    
                    $output = Join-Path $outputpath "${newfile}_${samplerate}_${bitrate}.${codec}"
                    $line = "ffmpeg -y -i $audio_file -ac 1 -ar $samplerate -ab $bitrate $output"

                    write-output "echo ""$line"""
                    write-output $line
                }
            }
        }
    } 
    
}


# $samplerates = @()
# $samplerates[0] = [PSCustomObject]@{    
#     SampleRate = "22000"
#     BitRate = "64000"
# }


if ($generate) {
    #New-Item -ItemType Directory -Force -Path C:\Path\That\May\Or\May\Not\Exist
    "#!/usr/bin/env bash" | out-file ./degrade.sh
    Create-ConversionScript | ForEach-Object { $_ | out-file ./degrade.sh -Append -NoClobber}

    
}
