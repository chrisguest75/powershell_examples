# README

Demonstrate how to run powershell inside a docker container  

## Process

```sh
docker build -t powershell .   
docker run -it --entrypoint /bin/pwsh powershell
```

## Resources

* https://docs.microsoft.com/en-us/powershell/scripting/install/install-debian?view=powershell-7.2
