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

## Resources

* adamdriscoll/awesome-powershell repo [here](https://github.com/adamdriscoll/awesome-powershell)
* `cheatsheet powershell`
