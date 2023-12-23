# EXECUTION POLICY

The execution policy is designed to control the level of security surrounding the execution of PowerShell scripts. It determines whether PowerShell scripts can be run on a particular system and under what conditions.  

```ps1
Get-ExecutionPolicy -List

Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine

Get-ExecutionPolicy -List

Scope ExecutionPolicy
        ----- ---------------
MachinePolicy       Undefined
   UserPolicy       Undefined
      Process       Undefined
  CurrentUser    RemoteSigned
 LocalMachine    RemoteSigned
```

## Resources

* Set-ExecutionPolicy [here](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.security/set-executionpolicy)  
