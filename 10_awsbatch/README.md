# README

Demonstrate using the official AWS Powershell Module for Batch

## Run Show-Queues

```ps1
. ./.env.ps1   
./show-queues.ps1  
```

## Troubleshoot batch

```ps1
. ./.env.ps1   
./troubleshoot-batch.ps1 -showqueues
./troubleshoot-batch.ps1 -jobs -queue queuename

(./troubleshoot-batch.ps1 -jobdetails -jobid  c5247910-255d-462c-a797-18a651fd0197).Attempts[0].Container

```

## Installation

```ps1
# ensure powershellget is installed
Install-Module -Name PowerShellGet -RequiredVersion 2.2.1 -Force

# install batch module 
Find-Module  -Name "AWS.Tools.Batch*"
Install-Module -Name "AWS.Tools.Batch"
Get-InstalledModule
Import-Module "AWS.Tools.Batch"
Find-Command -ModuleName "AWS.Tools.Common"
Find-Command -ModuleName "AWS.Tools.Batch"

# sort functions by name
Find-Command -ModuleName "AWS.Tools.Common" | sort-object Name
```

## Configure AWS

```ps1
Get-AWSCredential -ListProfile

# set default
Set-AWSCredential -ProfileName $profilename
```

## Cloudwatch Logs

```ps1
Install-Module -Name "AWS.Tools.CloudWatchLogs"  
Find-Command -ModuleName "AWS.Tools.CloudWatchLogs"  
Import-Module "AWS.Tools.CloudWatchLogs"  

Get-CWLLogEvent -LogGroupName "/aws/batch/job" -LogStreamNamePrefix "logstream/default/e118a5d1cf2e4582927c0d5e88719388"       
(Get-CWLLogEvent -LogGroupName "/aws/batch/job" -LogStreamName "logstream/default/e118a5d1cf2e4582927c0d5e88719388").Events  

# get environment variables for the job
(Get-BATJobDetail -Job 83cac4f9-5f91-47ed-88c0-9d66333c547c).Container.Environment.Value

# get out of memory failures
./troubleshoot-batch.ps1 -jobs -queue $queuename | where { if ($null -ne $_.Reason) {$_.Reason.StartsWith("OutOfMemoryError")} else { return False} } | select JobId | % { (Get-BATJobDetail -Job $_.JobId).Container.Environment.Value}
```

## Resources  

* aws/aws-tools-for-powershell repo [here](https://github.com/aws/aws-tools-for-powershell)
* AWS Tools for PowerShell - Installation [here](https://docs.aws.amazon.com/powershell/latest/reference/Index.html)
