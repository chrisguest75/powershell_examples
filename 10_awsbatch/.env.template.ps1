$env:AWS_PROFILE=""
$env:AWS_REGION=""
$env:MONGOCONNECTION=""

#Get-AWSCredential
Set-AWSCredential -ProfileName $env:AWS_PROFILE
#Get-DefaultAWSRegion 
Set-DefaultAWSRegion -Region $env:AWS_REGION
