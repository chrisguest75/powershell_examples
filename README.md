# README

Powershell examples.

TODO:

    * interesting libraries (git)
    * ssh and remoting.  

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

## 01 - Basic Commands

Demonstrate some basic commands in Powershell  
Steps [README.md](./01_basic_commands/README.md)  

## 02 - JSON

Demonstrate how to deal with `json` data in Powershell  
Steps [README.md](./02_json/README.md)  

## 03 - Docker

Demonstrate how to run powershell inside a docker container  
Steps [README.md](./03_docker/README.md)  

## 04 - Mongo Module

Demonstrate how to install and use a `mongo` packages  
Steps [README.md](./04_mongo_module/README.md)  

## 06 - AWS CLI

Demonstrate how to use AWS cli and parse answers with `powershell`.  
Steps [README.md](./06_awscli/README.md)  

## Resources

* adamdriscoll/awesome-powershell repo [here](https://github.com/adamdriscoll/awesome-powershell)
* `cheatsheet powershell`
