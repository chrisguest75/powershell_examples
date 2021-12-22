# README

Demonstrate how to run powershell inside a docker container  

## Process

```sh
docker build -t powershell .   
docker run -it --entrypoint /bin/pwsh powershell
```

## Resources

* Installing PowerShell on Debian Linux [here](https://docs.microsoft.com/en-us/powershell/scripting/install/install-debian?view=powershell-7.2)
* Using PowerShell in Docker [here](https://docs.microsoft.com/en-us/powershell/scripting/install/powershell-in-docker?view=powershell-7.2)