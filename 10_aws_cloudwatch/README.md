# Cloudwatch

Demonstrate how to use Cloudwatch metrics API to pull back datapoints on S3 buckets.  

## Install

```powershell
Find-Module  -Name "AWS.Tools.S3"
Install-Module  -Name "AWS.Tools.S3"
```

## Check

```sh
./bucket_sizes.ps1 -environment dev
```

## Resources

* AWS Tools for PowerShell [here](https://docs.aws.amazon.com/powershell/latest/reference/Index.html)  
