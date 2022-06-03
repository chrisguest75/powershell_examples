# README

[![Repository](https://skillicons.dev/icons?i=powershell,docker,linux)](https://skillicons.dev)

Powershell examples.

📝 TODO:

* interesting libraries (git) https://www.powershellgallery.com/packages/PowerGit/0.9.0
* Plaster
* NPM package example - using from typescript
* $isDotSourced = $MyInvocation.InvocationName -eq '.' -or $MyInvocation.Line -eq ''
* -passthru
* fix help for about_
* error handling

## 📋 Prereqs

```sh
# current version
brew info powershell 

# install
brew install powershell

# upgrade
brew upgrade powershell
```

```sh
# open shell
pwsh

# check versions
$psversiontable

# list the currently installed modules.
Get-InstalledModule
Get-Module -ListAvailable   

# Troubleshooting
# if modules are failing to load and you already have the modules installed try upgrading them.
Update-AWSToolsModule  
```

## 🏠 Enable brew

```ps1
# add brew support to powershell
Add-Content -Path $PROFILE.CurrentUserAllHosts -Value '$(/usr/local/bin/brew shellenv) | Invoke-Expression'
```

## 00 - Basic Commands

Demonstrate some basic commands in Powershell  
Steps [README.md](./00_basic_commands/README.md)  

## 01 - Template

A template script as an example to create others.  
Steps [README.md](./01_template_script/README.md)  

## 02 - JSON

Demonstrate how to deal with `json` data in Powershell  
Steps [README.md](./02_json/README.md)  

## 03 - Docker

Demonstrate how to run powershell inside a docker container  
Steps [README.md](./03_docker/README.md)  

## 04 - Mongo Module

Demonstrate how to install and use a `mongo` packages  
Steps [README.md](./04_mongo_module/README.md)  

## 05 - Pester

Demonstrate how to run pester to test a script  
Steps [README.md](./05_pester/README.md)  

## 06 - AWS CLI

Demonstrate how to use AWS cli and parse answers with `powershell`.  
Steps [README.md](./06_awscli/README.md)  

## 07 - String Generation

Demonstrate text generation effects.  
Steps [README.md](./07_string_generation/README.md)  

## 08 - Iterate Folders

Demonstrate iterating over files and directories  
Steps [README.md](./08_iterate_folders/README.md)  

## 09 - Jupyter

Demonstrate how to get a `jupyter` server running  
Steps [README.md](./09_jupyter/README.md)  

## 10 - awsbatch

Demonstrate using the official AWS Powershell Module for Batch  
Steps [README.md](./10_awsbatch/README.md)  

## 10 - awsecs

Demonstrate using the official AWS Powershell Module for ECS  
Steps [README.md](./10_awsecs/README.md)  

## 11 - logging

Demonstrate logging libraries for Powershell  
Steps [README.md](./11_logging/README.md)  

## 12 - remoting

Configure SSH Remoting in Powershell.  
Steps [README.md](./12_remoting/README.md)  

## 17 - oh-my-posh

Demonstrate some `oh-my-posh` basics
Steps [README.md](./17_ohmyposh/README.md)  

## 19 - PSScriptAnalyzer

Demonstrate use of `PSScriptAnalyzer` to lint code.  
Steps [README.md](./19_scriptanalyser/README.md)  

## 20 - pode webserver

Use `pode` to build a simple webserver.  
Steps [README.md](./20_pode/README.md)  

## 20 - AST

Demonstrate use to parser and AST on scripts.  
Steps [README.md](./21_ast/README.md)  

## 22 - dotnet

Demonstrate using dotnet core libraries  
Steps [README.md](./22_dotnet/README.md)  

## 24 - trint apis

Demonstate using `trint` live API  
Steps [README.md](./24_trint_apis/README.md)  

## 👀 Resources

* Official product documentation for PowerShell [here](https://docs.microsoft.com/en-us/powershell/)
* adamdriscoll/awesome-powershell repo [here](https://github.com/adamdriscoll/awesome-powershell)
* `cheatsheet powershell`
* PowerShell/PowerShell repo [here](https://github.com/PowerShell/PowerShell)

