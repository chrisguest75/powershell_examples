function Get-UrlEncode([string]$toEncode) {
    Add-Type -AssemblyName System.Web
    [System.Web.HttpUtility]::UrlEncode($toEncode)
}