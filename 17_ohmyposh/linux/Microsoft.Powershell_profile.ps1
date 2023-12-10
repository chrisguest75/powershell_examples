oh-my-posh init pwsh --config ~\.oh-my-posh\themes\chrisguest.omp.json | Invoke-Expression

Import-Module -Name Terminal-Icons

Set-PSReadLineOption -Colors @{
    "Operator" = [ConsoleColor]::Magenta;
    "Parameter" = [ConsoleColor]::Magenta
}