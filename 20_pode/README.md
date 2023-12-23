# README

Use `pode` to build a simple webserver.  

Pode is a Cross-Platform framework to create web servers that host REST APIs, Web Sites, and TCP/SMTP Servers. Pode documentation [here](https://badgerati.github.io/Pode/)  

NOTE:

* I took some old `pode` code, but it kept crashing. It seemed that the old code had a different package.json and this was causing issues. So if failing rerun `pode init` to compare differences.  
* You can restart the server using `ctrl+r`  

## Install

```ps1
Install-Module -Name Pode -Force

# help for pode
get-help pode
```

## Start

```ps1
# start server
pode start
```

## Create

```ps1
# create config (configure npm and ./server.ps1)
pode init
```

## Resources

* Building your first Pode app [here](https://badgerati.github.io/Pode/Getting-Started/FirstApp/#rest-server)  
* Pode documentation [here](https://badgerati.github.io/Pode/)
* https://github.com/Badgerati/Pode
* https://github.com/Badgerati/Pode.Web
