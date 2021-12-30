#!/usr/bin/env pwsh

# this was used to generate some keyframe animations for a blob like effect in CSS. 

for($index = 0; $index -le 100; $index+=10)
{
    $values = Get-Random -Minimum 10 -Maximum 90 -Count 8

    write-host "$index% {border-radius:$($values[0])% $($values[1])% $($values[2])% $($values[3])% / $($values[4])% $($values[5])% $($values[6])% $($values[7])%}"
}

