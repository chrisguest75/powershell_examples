# README

Demonstrate using dotnet core libraries  

## Get Abstract Syntax Tree

```ps1
Import-Module ./DotNet-Tools.psm1 -Force

Get-AppDomainAssemblies           
Get-AssemblyTypes("System.Security.Cryptography.Algorithms")  
Get-UrlEncode("System.Threading, Version=6.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a")     
```
