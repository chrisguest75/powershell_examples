# README

Demonstrate using the official AWS Powershell Module for Batch

## Process

```ps1
Install-Module -Name PowerShellGet -RequiredVersion 2.2.1 -Force

Find-Module  -Name "AWS.Tools.Batch*"

Install-Module -Name "AWS.Tools.Batch"
Get-InstalledModule
Import-Module "AWS.Tools.Batch"
Find-Command -ModuleName "AWS.Tools.Common"
Find-Command -ModuleName "AWS.Tools.Batch"

# sorted by name
Find-Command -ModuleName "AWS.Tools.Common" | sort-object Name
```

## Run Show-Queues

```ps1
. ./.env.ps1   
./show-queues.ps1  
```

## Configure AWS

```ps1
Get-AWSCredential -ListProfile

# set default
Set-AWSCredential -ProfileName $profilename
```

```ps1
# if default profile set
Get-BATJobQueue 

# if not
Get-BATJobQueue -ProfileName $profilename
Get-BATJobQueue -ProfileName $profilename | select-object  JobQueueName
```

## Resources  

* aws/aws-tools-for-powershell repo [here](https://github.com/aws/aws-tools-for-powershell)
* AWS Tools for PowerShell - Installation [here](https://docs.aws.amazon.com/powershell/latest/reference/Index.html)
