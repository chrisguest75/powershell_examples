function Parse([string]$filePath)
{
    $parser = [System.Management.Automation.PsParser]

    $file = $parser::Tokenize((Get-Content $filePath), [ref] $null) 
    $file |% {
	    $PSToken = $_
	    
        $pstoken |% {"[" + $_.StartLine + "] [" + $_.type + "] " + $_.content}
        #if($PSToken.Type -eq  'Keyword' -and $PSToken.Content -eq 'Function' ) 
	    #{     
		#    $functionKeyWordFound = $true
	    #}

	    #if($functionKeyWordFound -and ($PSToken.Type -eq 'CommandArgument')) 
	    #{
		#    '' | Select ` 
		#    @{
	    #	    Name="FunctionName"
		#	    Expression={$PSToken.Content}
		#    },
		#    @{
		#	    Name="Line"
		#	    Expression={$PSToken.StartLine}
		#    },
		#    @{
		#	    Name="File"
		#	    Expression={$filePath}
		#    }
           #
		#    $functionKeyWordFound = $false
	    #}
    }
}

function Ast([string]$filePath)
{
	{(Get-Content $filePath)}.Ast
}

write-host "PARSER"
Parse "parse-file.ps1"
write-host "AST"
Ast "parse-file.ps1"
