Import-Module -Name Pode -MaximumVersion 2.99.99
Import-Module Pode.Web

Start-PodeServer {
    # add a simple endpoint
    Add-PodeEndpoint -Address "0.0.0.0" -Port 8080 -Protocol Http

    # set the use of the pode.web templates
    Use-PodeWebTemplates -Title 'Example' -Theme Dark

    # add the page
    Add-PodeWebPage -Name Processes -Icon Activity -ScriptBlock {
        New-PodeWebChart -Name 'Top Processes' -Type Bar -AutoRefresh -AsCard -ScriptBlock {
            Get-Process |
                Sort-Object -Property CPU -Descending |
                Select-Object -First 10 |
                ConvertTo-PodeWebChartData -LabelProperty ProcessName -DatasetProperty CPU
        }
    }
}