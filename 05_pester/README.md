# README

Demonstrate how to run pester to test a script

## Process

```sh
pwsh
```

## Install  

```sh
Install-Module -Name Pester -Force
Get-InstalledModule
```

## Run tests

```ps1
Import-Module Pester
Invoke-Pester ./Common/
Invoke-Pester ./Common/ -Output Detailed
```

## Resources

* pester/Pester repo [here](https://github.com/pester/Pester)  
* The test framework for Powershell [here](https://pester-docs.netlify.app/)  
