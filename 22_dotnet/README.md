# README

Demonstrate using dotnet core libraries  

## Use

```ps1
Import-Module ./DotNet-Tools.psm1 -Force

# list all loaded assemblies
Get-AppDomainAssemblies           

# reflection on the assembly
Get-AssemblyTypes("System.Security.Cryptography.Algorithms")  

# demonstrate proxying into a .net method
Get-UrlEncode("System.Threading, Version=6.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a")     
```
