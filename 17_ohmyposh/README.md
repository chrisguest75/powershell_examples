# README

Demonstrate some `oh-my-posh` basics.  

TODO:

* Get this setup correctly on WSL and linux.  

## Table of contents

- [README](#readme)
  - [Table of contents](#table-of-contents)
  - [Install (windows)](#install-windows)
  - [Configure profile (windows)](#configure-profile-windows)
  - [Install (brew)](#install-brew)
  - [Configure profile (brew)](#configure-profile-brew)
  - [Terminal Icons](#terminal-icons)
  - [Fix Colours](#fix-colours)
  - [Resources](#resources)

NOTES:

* Install terminal icons.  
* Ensure that the "MesloLGM Nerd Font Mono" is installed.  
* Ensure you have upgraded to Powershell >7.4 on Windows

## Install (windows)

```powershell
winget install JanDeDobbeleer.OhMyPosh -s winget

# as admin (install Meslo Nerd Font)
oh-my-posh font install

oh-my-posh --init --shell pwsh --config .\chrisguest.omp.json | Invoke-Expression
echo $env:POSH_THEME
echo $env:POSH_THEMES_PATH

# load the themes in 
code $env:POSH_THEMES_PATH

Get-PoshThemes
```

## Configure profile (windows)

```ps1
# print location of profile
write-host $profile

write-host C:\Users\$env:USERNAME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1

# create profile location and copy over stored one
mkdir ~\Documents\PowerShell\
cp .\windows\*_profile.ps1 ~\Documents\PowerShell\
cat $profile

# copy over my theme
mkdir ~/.oh-my-posh/themes/
cp ./chrisguest.omp.json ~/.oh-my-posh/themes/

# reload profile
. $PROFILE

echo $env:POSH_THEME
```

## Install (brew)

```sh
# can be installed using brew but not required
brew install jandedobbeleer/oh-my-posh/oh-my-posh

# show themes directory
ls -l $(brew --prefix oh-my-posh)/themes

# 
pwsh
oh-my-posh --init --shell pwsh --config ~/jandedobbeleer.omp.json | Invoke-Expression
. $PROFILE
```

## Configure profile (brew)

```ps1
write-host $profile

/Users/$env:USER/.config/powershell/Microsoft.VSCode_profile.ps1

/Users/$env:USER/.config/powershell/Microsoft.PowerShell_profile.ps1

cp *_profile.ps1 ~/.config/powershell/

cp ./chrisguest.omp.json ~/.oh-my-posh/themes/
#cp ./chrisguest.omp.json $(brew --prefix oh-my-posh)/themes 
```

## Terminal Icons

```ps1
Install-Module -Name Terminal-Icons -Repository PSGallery
Import-Module -Name Terminal-Icons
get-childitem
```

## Fix Colours

My standard solarised shell hides parameters.  Some default powershell colours need to be changed.  

```ps1
Set-PSReadLineOption -Colors @{
    "Operator" = [ConsoleColor]::Magenta;
    "Parameter" = [ConsoleColor]::Magenta
}

# test it (can you see the parameters?)
wsl --list --verbose
```

## Resources

* Oh My Posh A prompt theme engine for any shell. [here](https://ohmyposh.dev)
* JanDeDobbeleer/oh-my-posh [here](https://github.com/JanDeDobbeleer/oh-my-posh)
* My Ultimate PowerShell prompt with Oh My Posh and the Windows Terminal [here](https://www.hanselman.com/blog/my-ultimate-powershell-prompt-with-oh-my-posh-and-the-windows-terminal)
* Making Windows Terminal look awesome with oh-my-posh [here](https://zimmergren.net/making-windows-terminal-look-awesome-with-oh-my-posh/)
* Tweaking the PowerShell colour scheme to play nice with the new Windows Terminal [here](https://stevenknox.net/tweaking-powershell-color-scheme-to-play-nice-with-the-new-windows-terminal/)
