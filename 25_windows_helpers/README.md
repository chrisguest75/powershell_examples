# WINDOWS HELPERS

A set of helpers for working with Windows.  

## Print Font Names

Stupidly Windows does not allow you to copy fonts names in the app.  

```sh
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
(New-Object System.Drawing.Text.InstalledFontCollection).Families
```

## Resources
