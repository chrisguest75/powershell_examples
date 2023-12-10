# WINDOWS HELPERS

A set of helpers for working with Windows.  

## Print Font Names

Stupidly Windows does not allow you to copy fonts names in the app.  

```powershell
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
(New-Object System.Drawing.Text.InstalledFontCollection).Families
```

## Versions

```powershell
# get os version object
[System.Environment]::OSVersion
```

## Shutdown

```powershell
# shutdown the computer immediately
Stop-Computer -ComputerName localhost
```

## Resources
