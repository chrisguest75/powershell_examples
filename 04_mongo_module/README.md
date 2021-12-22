# README

Demonstrate how to install and use a `mongo` packages

## Startup

```sh
# list profiles
docker compose config --profiles               

# start mongo (profiles not working at the mo')
# It is working in compose: Docker Compose (Docker Inc., v2.0.0-beta.6) - Docker Desktop 3.5.2
docker compose --profile backend up -d 

# quick test
docker logs $(docker ps --filter name=04_installing_modules-mongodb-1 -q)
docker logs $(docker ps --filter name=04_installing_modules-client-1 -q)


```

## Process

```ps1
docker exec -it $(docker ps --filter name=04_installing_modules-client-1 -q) /bin/pwsh 

Install-Module -Name PowerShellGet -RequiredVersion 2.2.1 -Force

Install-Module -Name Mdbc
Import-Module Mdbc

Connect-Mdbc mongodb://root:rootpassword@mongodb:27017 test test -NewCollection     

# Add two documents
@{_id = 1; value = 42}, @{_id = 2; value = 3.14} | Add-MdbcData

# Get documents as PS objects
Get-MdbcData -As PS | Format-Table

# Get the document by _id
Get-MdbcData @{_id = 1}

# Update the document, set 'value' to 100
Update-MdbcData @{_id = 1} @{'$set' = @{value = 100}}

# Get the document again, 'value' is 100
$doc = Get-MdbcData @{_id = 1}

# Remove the document
$doc | Remove-MdbcData

# Count documents, 1
Get-MdbcData -Count
```

## Resources
https://www.powershellgallery.com/
https://www.powershellgallery.com/packages/PowerShellGet/2.2.1
https://www.powershellgallery.com/packages/Mdbc/6.5.12
https://github.com/nightroman/Mdbc