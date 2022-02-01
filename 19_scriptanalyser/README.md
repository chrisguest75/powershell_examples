# README

Demonstrate use of `PSScriptAnalyzer` to lint code.  

## Install

```ps1
Install-Module -Name PSScriptAnalyzer -Force
Get-InstalledModule
```

## Analyzer

```ps1
# run lint
Invoke-ScriptAnalyzer -Path ./simple-script.ps1

# show linter is also outputing objects
Invoke-ScriptAnalyzer -Path ./simple-script.ps1 | select Line,RuleName
```

## Resources

* PSScriptAnalyzer repo [here](https://github.com/PowerShell/PSScriptAnalyzer)
