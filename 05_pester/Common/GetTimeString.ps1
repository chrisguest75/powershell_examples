#***************************************************************************************************************
#** Get a string representation of time
#***************************************************************************************************************

function Get-DateNow()
{
    return [datetime]::Now
}

function Get-TimeString()
{
    $now = Get-DateNow
    $filesafe = "{0:D2}{1:D2}{2:D2}" -f $now.hour,$now.minute,$now.second
    return $filesafe
}
