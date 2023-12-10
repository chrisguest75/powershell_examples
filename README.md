# README

[![Repository](https://skillicons.dev/icons?i=powershell,docker,linux)](https://skillicons.dev)

Powershell examples.

## Contents

- [README](#readme)
  - [Contents](#contents)
  - [📋 Prereqs](#-prereqs)
    - [Windows](#windows)
    - [MacOS](#macos)
    - [WSL Ubuntu](#wsl-ubuntu)
  - [Test](#test)
  - [🏠 Enable brew](#-enable-brew)
  - [00 - Basic Commands](#00---basic-commands)
  - [01 - Template](#01---template)
  - [02 - JSON](#02---json)
  - [03 - Docker](#03---docker)
  - [04 - Mongo Module](#04---mongo-module)
  - [05 - Pester](#05---pester)
  - [06 - AWS CLI](#06---aws-cli)
  - [07 - String Generation](#07---string-generation)
  - [08 - Iterate Folders](#08---iterate-folders)
  - [09 - Jupyter](#09---jupyter)
  - [10 - awsbatch](#10---awsbatch)
  - [10 - awsecs](#10---awsecs)
  - [11 - logging](#11---logging)
  - [12 - remoting](#12---remoting)
  - [17 - oh-my-posh](#17---oh-my-posh)
  - [19 - PSScriptAnalyzer](#19---psscriptanalyzer)
  - [20 - pode webserver](#20---pode-webserver)
  - [20 - AST](#20---ast)
  - [22 - dotnet](#22---dotnet)
  - [24 - trint apis](#24---trint-apis)
  - [25 - windows helpers](#25---windows-helpers)
  - [👀 Resources](#-resources)

## 📋 Prereqs

### Windows

Ensure that Powershell is upgraded to the latest version [here](https://learn.microsoft.com/en-gb/powershell/scripting/install/installing-powershell-on-windows)  

Switch the terminal app to point to `C:\Program Files\PowerShell\7\pwsh.exe` to start and configure `oh-my-posh` [chrisguest75/powershell_examples/17_ohmyposh/README.md](https://github.com/chrisguest75/powershell_examples/blob/main/17_ohmyposh/README.md)  

### MacOS

```sh
# current version
brew info powershell 

# install
brew install powershell

# upgrade
brew upgrade powershell
```

### WSL Ubuntu

Based on [powershell/scripting/install/install-ubuntu](https://learn.microsoft.com/en-us/powershell/scripting/install/install-ubuntu?view=powershell-7.3)  

```sh
###################################
# Prerequisites

# Update the list of packages
sudo apt-get update

# Install pre-requisite packages.
sudo apt-get install -y wget apt-transport-https software-properties-common

# Get the version of Ubuntu
source /etc/os-release

# Download the Microsoft repository keys
wget -q https://packages.microsoft.com/config/ubuntu/$VERSION_ID/packages-microsoft-prod.deb

# Register the Microsoft repository keys
sudo dpkg -i packages-microsoft-prod.deb

# Delete the the Microsoft repository keys file
rm packages-microsoft-prod.deb

# Update the list of packages after we added packages.microsoft.com
sudo apt-get update

###################################
# Install PowerShell
sudo apt-get install -y powershell

# Start PowerShell
pwsh
```

## Test

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
Steps [README.md](./10_aws_batch/README.md)  

## 10 - awsecs

Demonstrate using the official AWS Powershell Module for ECS  
Steps [README.md](./10_aws_ecs/README.md)  

## 11 - logging

Demonstrate logging libraries for Powershell  
Steps [README.md](./11_logging/README.md)  

## 12 - remoting

Configure SSH Remoting in Powershell.  
Steps [README.md](./12_remoting/README.md)  

## 17 - oh-my-posh

Demonstrate some `oh-my-posh` basics.  
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

## 25 - windows helpers

A set of helpers for working with Windows.  
Steps [README.md](./25_windows_helpers/README.md)  

## 👀 Resources

* Official product documentation for PowerShell [here](https://docs.microsoft.com/en-us/powershell/)
* adamdriscoll/awesome-powershell repo [here](https://github.com/adamdriscoll/awesome-powershell)
* Use `cheatsheet powershell`
* PowerShell/PowerShell repo [here](https://github.com/PowerShell/PowerShell)
