# README

Configure SSH Remoting in Powershell

## Configure remote machine

```sh
ssh-add ~/.ssh/key
ssh-copy-id name@machine
ssh -A -o StrictHostKeyChecking=no name@machine

which pwsh
sudo nano /etc/ssh/sshd_config
```

```ini
# add the subsystem for powershell
Subsystem powershell /usr/bin/pwsh -sshs -NoLogo
```

## Connect using remoting

```ps1
$session = New-PSSession -HostName 192.168.1.222 -UserName chrisguest
Enter-PSSession $session

Exit-PSSession
```

## Invoke remote commands

```ps1
Invoke-Command $session -ScriptBlock { Get-Process }
```

## Resources  

* PowerShell remoting over SSH [here](https://docs.microsoft.com/en-us/powershell/scripting/learn/remoting/ssh-remoting-in-powershell-core?view=powershell-7.2)

