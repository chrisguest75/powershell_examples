# README

Demonstrate creating and using custom modules.  

## Create

```ps1
New-ModuleManifest -Path ./my-custommodule/my-custommodule.psd1 -ModuleVersion "2.0" -Author "chrisguest" 
import-module my-custommodule
```


## Installation

```ps1
# list modules
Get-Module -ListAvailable
Get-InstalledModule

# ensure powershellget is installed
Install-Module -Name PowerShellGet -RequiredVersion 2.2.1 -Force

# install batch module 
Find-Module -Name "AWS.Tools.Batch*"
Install-Module -Name "AWS.Tools.Batch"

Import-Module "AWS.Tools.Batch"
Find-Command -ModuleName "AWS.Tools.Common"

# sort functions by name
Find-Command -ModuleName "AWS.Tools.Common" | sort-object Name
```




Install-Module -Name Plaster -Force


## Resources

* How to Write a PowerShell Script Module [here](https://docs.microsoft.com/en-us/powershell/scripting/developer/module/how-to-write-a-powershell-script-module?view=powershell-7.2)  
* How to write a PowerShell module manifest [here](https://docs.microsoft.com/en-us/powershell/scripting/developer/module/how-to-write-a-powershell-module-manifest?view=powershell-7.2)  


https://mikefrobbins.com/2018/02/15/using-plaster-to-create-a-powershell-script-module-template/

https://github.com/PowerShellOrg/Plaster
