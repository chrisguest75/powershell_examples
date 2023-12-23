Import-Module -Name Pode -MaximumVersion 2.99.99



Start-PodeServer {
    # logic
    Add-PodeEndpoint -Address localhost -Port 8080 -Protocol Http
    New-PodeLoggingMethod -Terminal | Enable-PodeRequestLogging

    Add-PodeRoute -Method Get -Path '/' -ScriptBlock {
        $random = Get-Random -Minimum 0 -Maximum 99 -Count 1
        Write-PodeJsonResponse -Value @{ 
            'path' = 'Root'; 
            'random' = $random }
    }

    Add-PodeRoute -Method Get -Path '/processes' -ScriptBlock {
        $random = Get-Random -Minimum 0 -Maximum 99 -Count 1
        $processes = (Get-Process | Select-Object id,processname)
        Write-PodeJsonResponse -Value @{ 
            'path' = 'Processes';
            'process' = $processes 
            'random' = $random }
        
        #Write-PodeJsonResponse -Value $processes
    }

}