Import-Module oh-my-posh
Set-PoshPrompt -Theme chrisguest
#Set-PoshPrompt -Theme powerline
#Set-PoshPrompt -Theme powerline_chrisguest
# Set-PoshPrompt -Theme powerlevel10k_classic
#Set-PoshPrompt -Theme powerlevel10k_chrisguest

Import-Module -Name Terminal-Icons

Set-PSReadLineOption -Colors @{
    "Operator" = [ConsoleColor]::Magenta;
    "Parameter" = [ConsoleColor]::Magenta
}
