# README

Demonstrate using the official AWS Powershell Module for Batch

## Run Show-Queues

```ps1
. ./.env.ps1   
./troubleshoot-ecs.ps1 -showclusters
```

## Installation

```ps1
Install-Module -Name PowerShellGet -RequiredVersion 2.2.1 -Force

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

Get-ECSTaskDetail -Task "arn:aws:ecs:region:account:task/id"
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
