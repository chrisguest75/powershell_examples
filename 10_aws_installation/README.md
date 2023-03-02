# README

Demonstrate using the official AWS Powershell Module  

## Install & Configure

```sh
# install macoxs
brew install powershell

# linux (should be in standard package provider)

# open shell
pwsh   
```

## Updating Modules

```ps1
# ensure powershellget is installed
Install-Module -Name PowerShellGet -RequiredVersion 2.2.1 -Force

Get-InstalledModule

# reinstall the installer
Install-Module -Name AWS.Tools.Installer -force

# if modules are failing to load and you already have the modules installed try upgrading them.
Update-AWSToolsModule  
```

## Installation

```ps1
# install batch module 
Find-Module  -Name "AWS.Tools.Batch*"
Install-Module -Name "AWS.Tools.Batch"
Get-InstalledModule
Import-Module "AWS.Tools.Batch"
Find-Command -ModuleName "AWS.Tools.Common"
Find-Command -ModuleName "AWS.Tools.Batch"

# sort functions by name
Find-Command -ModuleName "AWS.Tools.Common" | sort-object Name

# install ecs
Find-Module  -Name "AWS.Tools.ECS*"
Install-Module -Name "AWS.Tools.ECS"
Get-InstalledModule
Import-Module "AWS.Tools.ECS"
Find-Command -ModuleName "AWS.Tools.Common"
Find-Command -ModuleName "AWS.Tools.ECS"

# sorted by name
Find-Command -ModuleName "AWS.Tools.ECS" | sort-object Name

# list organisations 
Find-Module  -Name "AWS.Tools.Organizations*"
Install-Module  -Name "AWS.Tools.Organizations"
Get-ORGRoot 
Get-ORGAccountList
```

## Configure AWS

```ps1
Get-AWSCredential -ListProfile

# set default
Set-AWSCredential -ProfileName $profilename
```

## Resources  

* aws/aws-tools-for-powershell repo [here](https://github.com/aws/aws-tools-for-powershell)  
* AWS Tools for PowerShell - Installation [here](https://docs.aws.amazon.com/powershell/latest/reference/Index.html)  
* Job definition parameters [here](https://docs.aws.amazon.com/batch/latest/userguide/job_definition_parameters.html)  
* Installing AWS Tools for PowerShell on Linux or macOS [here](https://docs.aws.amazon.com/powershell/latest/userguide/pstools-getting-set-up-linux-mac.html)  
