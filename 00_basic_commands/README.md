# README

Demonstrate some basic commands in Powershell

```ps1
############################################################
# Versions
############################################################
$psversiontable
```

## Alias and commands

```ps1
get-alias

# clear the screen
cls -> Clear-Host  
```

## Help

```ps1
############################################################
# Help 
############################################################
sudo pwsh  
Update-Help -Module Microsoft.PowerShell* -Verbose
Get-Module -ListAvailable     


update-help
get-help *
get-help get-help
get-help default –detailed
```

```ps1
############################################################
# VERB-NOUN
############################################################
#http://social.technet.microsoft.com/wiki/contents/articles/4537.aspx
get-verb

#** NOT WORKING category filtering **
get-help * -Category Cmdlet | sort-object name | format-table
get-help * -category alias
```

## Pipes

```ps1
############################################################
# Piping
############################################################
gps | where ProcessName -eq "zsh" | sort-object -Property Id -Descending
# format table
gps | where ProcessName -eq "zsh" | sort-object -Property Id -Descending | format-table -autosize
```

## Type Conversion

```ps1
############################################################
# Accelerators
############################################################
[psobject].assembly.gettype("System.Management.Automation.TypeAccelerators")::Get
[int]"not an int“
[float]"32.4"
```

## Reflection

```ps1
############################################################
# Reflection
############################################################
[uint16]$a | get-member
[switch]$a | get-member
“hello” | get-member
```

## XML

```ps1
############################################################
# Xml
############################################################
$x = [xml]"<n>hello</n>"
$x
$x | get-member

$x = [xml]"<n><c>hello</c></n>"
$x.n

$x = [xml]"<a><b><c>1</c><c>2</c><c>3</c></b></a>"
$x | select-xml "a/b/c" | foreach {$_.Node}
$x.a.b.c
$x.a.b.c |% {[int]$_ * 8}
```

## Providers

```ps1
############################################################
# Providers
############################################################

get-psdrive

dir function:*
dir variable:*
dir env:*
```

## File functions

```ps1
############################################################
# Demonstrate files 
############################################################
set-content test.txt "hello"
get-content test.txt
add-content test.txt "world"
get-content test.txt
remove-item test.txt
```

## Provider iteration

```ps1
############################################################
# Demonstrate listing provider manipulation 
############################################################
(get-childitem "../")
(get-childitem Function:\cd..).Definition
(get-childitem Function:*)
(dir Function:\Clear-Host).Definition
```

## Arrays

```ps1
############################################################
# Array
############################################################

$array = @(1,2,3)
$array[0]
$array[2]
$array
$a = 1
$a[0]
$a[1]
```

## Constants

```ps1
############################################################
# Constants
############################################################
1MB * 2GB
8 * 1MB
1MB / 1KB
```

## Conditionals 

```ps1
############################################################
# Conditionals
############################################################
1 –eq 2
2 –eq 2
"hello" –eq "hello2"
"hello" –eq "hello"
"hello" -like "l*"
"hello" -like "z*"
```

## Loops

```ps1
############################################################
# Loops
############################################################
$array = @("disk1", "disk2", "disk4")
for($index = 0; $index -lt $array.Length; $index++)
{
write-host $array[$index]
}

$continue=$true
while($continue -eq $true) { 
write-host $continue
}
```

## External scripts and dotsourcing

```ps1
############################################################
# Scripts
############################################################

cls 
### Save the following line to a file called “AnArray.ps1”. 
if(test-path variable:array) {remove-item variable:array}
set-content “.\AnArray.ps1” (‘$array = @("disk1", "disk2", "disk4")’) 

############################################################
# Include Script
############################################################

write-host ("[ARRAY] "+ $array)
.\AnArray.ps1
write-host ("[ARRAY] "+ $array)

############################################################
# DotSourcing Script
############################################################
write-host ("[ARRAY] "+ $array)
. .\AnArray.ps1
write-host ("[ARRAY] "+ $array)

remove-item “.\AnArray.ps1” 
```

## Functions and return values

```ps1
############################################################
# Functions
############################################################
cls

function Print-Array([array]$arr)
{
	foreach($a in $arr) {
		write-host $a
	}
}

function Return-Multiple()
{
	"hello"
	"world"
	1+2+5
	1,2,4
}

Print-Array @(1,2,3)
Return-Multiple
```

## Attributes

```ps1
############################################################
# Attributes
############################################################
#http://msdn.microsoft.com/en-us/library/ms714836(v=VS.85).aspx

<#
.Synopsis
Checks the length of a string

.Description
Checks the length of a string is between 5 and 10 characters in length

.Parameter str
The string to check the length of.

.Example
Check-Length "hello"
This will succeed

.Example
Check-Length "hell"
This will fail

#>
function Check-Length
{
    Param (
	[parameter(Mandatory = $true)] [ValidateNotNullOrEmpty()] [ValidateLength(5,10)] [string]$str
    )

    write-host $str
}

<#
.Synopsis
Checks the pattern of a string

.Description
Checks the pattern of a string

.Parameter str
String to check

.Example

#>
function Check-Pattern
{
    Param (
    [parameter(Mandatory = $true)] [ValidateNotNullOrEmpty()] [ValidatePattern("^([a-z][:].*)`$|^([a-z])`$")] [string]$str
    )

    write-host $str
}

#Length between 5-10 should work
Check-Length "0123456"
#Length less than 5 should fail
Check-Length "012"
#Filepath style should work
Check-Pattern "f:\hello.txt"
#Non filepath style should fail
Check-Pattern "hello"

############################################################
# Get-help
############################################################
get-help check
get-help check-length -detailed
```

## Objects

```ps1
############################################################
# Types
############################################################
#http://blogs.msdn.com/b/powershell/archive/2006/11/24/what-s-up-with-psbase-psextended-psadapted-and-psobject.aspx
cls 

############################################################
# Demonstrate Custom Types 
############################################################

$myObject = [PSCustomObject]@{
    field1="field1"
    field2="field2"
}

############################################################
# Demonstrate Custom Types 
############################################################

$obj = new-object System.Object
add-member -inputobject $obj -membertype NoteProperty -Name "Name" -Value "myobject"
add-member -inputobject $obj -membertype NoteProperty -Name "Color" -Value "red"

$obj
$obj | get-member

############################################################
# Demonstrate PSObject 1
############################################################

$obj = new-object System.String "hello"
$obj | get-member
add-member -inputobject $obj -membertype NoteProperty -Name "Color" -Value "red"
$obj.Color

add-member -inputobject $obj -membertype ScriptProperty -Name "SquareLength" -Value {$this.Length * $this.Length}
$obj
$obj.SquareLength

############################################################
# Demonstrate PSObject 2
############################################################

$a = new-object psobject
$a | get-member
$a.psobject | get-member
$a.psobject.Members | get-member
$a.psobject.baseobject | get-member
$a = new-object system.object
$a | get-member
$a.psobject | get-member
$a.psobject.Members | get-member
$a.psobject.baseobject | get-member
```

## C# functions

```ps1
############################################################
# C#
############################################################

cls
function Create-MyObject()
{
    #Construct object to store properties in
    $csharp = @"
    public class MyObject
    {   
        public string Name {get;set;}
        public object Value {get;set;}
        public bool ReadOnly {get;set;}
        public string Description {get;set;}
    }
"@
    
    Add-Type $csharp -Language Csharp
}

Create-MyObject
$a = new-object MyObject
$a.Name = "hello"
$a.Value = "world"
$a
```

## Modules

```ps1
############################################################
# Modules
############################################################
cls

mkdir “./amodule"
Set-content "./amodule/amodule.psm1" (
"function Write-Module([string]`$str) { write-host `$str}
function Write-PrivateModule([string]`$str) { write-host `$str}
export-modulemember -function Write-Module")
import-module ./amodule/amodule.psm1
Write-Module "hello from a module"
Write-PrivateModule "cant find this"
(get-module amodule) | get-member
remove-item ./amodule                 
```

## Jobs

```ps1
############################################################
# Jobs
############################################################
cls
$a = Start-job {Invoke-WebRequest "www.google.com"}
$b = Start-job {Invoke-WebRequest “www.bing.com”}
Get-job 
Wait-job $a
Receive-job $a 
Wait-job $b
Receive-job $b

```

