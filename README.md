# README

Powershell examples.

TODO:

* interesting libraries (git)
* ssh and remoting.
* Create juypter example
* Plaster
* ScriptAnalyser
* NPM package example
* Logging
* $isDotSourced = $MyInvocation.InvocationName -eq '.' -or $MyInvocation.Line -eq ''

## Install

```sh
# install
brew install powershell
```

```sh
# open shell
pwsh
```

```ps1
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

## 10 - awsbatch

Demonstrate using the official AWS Powershell Module for Batch  
Steps [README.md](./10_awsbatch/README.md)  

## 12 - remoting

Configure SSH Remoting in Powershell.  
Steps [README.md](./12_remoting/README.md)  

## Resources

* adamdriscoll/awesome-powershell repo [here](https://github.com/adamdriscoll/awesome-powershell)
* `cheatsheet powershell`
