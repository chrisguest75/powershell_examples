# README

A template script as an example to create others.

## Create

The script should be created with a shebang  

```sh
#!/usr/bin/env pwsh
```

The execute permission is also required on the script if you are going to run from a traditional shell.  

```sh
chmod +x ./template.ps1
```

Add a simple check for no args printing out the help.  

```ps1
$showhelp = $false

if ( $PSBoundParameters.Values.Count -eq 0 -and $args.count -eq 0 ) {
    $showhelp = $true
}

if(($help -eq $true) -or ($showhelp -eq $true))
{
    Get-Help $MyInvocation.MyCommand.Definition -Detailed
    return
}
```

## Run

```sh
# no parameters show help
./template.ps1

# shows help
./template.ps1 -help

# pass a path
./template.ps1 -path .
```

## Resources
