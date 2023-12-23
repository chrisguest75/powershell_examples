# PODE WEB

Use `pode.web` to build a simple webserver.  

## Install

```ps1
Install-Module -Name Pode.Web -Force
```

## Start

```ps1
# start server
pode start
```

## Start Docker

```sh
# build 
docker build -t pode_web_server .

# run
docker run -p 8080:8080 --name pode_web_server -it --rm pode_web_server

# logs
docker logs pode_server

# stop
docker stop pode_server
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
* https://github.com/Badgerati/Pode.Web/tree/develop/examples