# S3 Compliance

A tool to help check buckets in an AWS account.  

TODO:

* Policies, Public Access, Encryption, Versioning, creation date, file count??, size, etc.

Demonstrates:

* Using progress bars to update status.  
* Add fields to objects.  
* Creating a single string from a dictionary of tags.  

## Install

```powershell
Find-Module  -Name "AWS.Tools.S3"
Install-Module  -Name "AWS.Tools.S3"
```

## Check

```sh
./compliance.ps1 -environment dev
```

## Resources

* AWS Tools for PowerShell [here](https://docs.aws.amazon.com/powershell/latest/reference/Index.html)  
