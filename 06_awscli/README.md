# README

Demonstrate how to use AWS cli and parse answers with `powershell`.  

## Process Batch Failures

```ps1
$queue = "batch-queue-name"
$failed = (aws --profile (Get-ChildItem -Path Env:\AWS_PROFILE).value --region us-east-1 batch list-jobs --job-queue $queue --job-status FAILED | ConvertFrom-Json)
$failed.jobSummaryList

$failed.jobSummaryList | Select-Object -Property status,jobId,jobName,@{
    label='createdAt'
    expression={(Get-Date 01.01.1970)+([System.TimeSpan]::fromseconds( $_.createdAt/1000))}
  },@{
    label='reason'
    expression={$_.container.reason}}

# could also write it back out 
$failed.jobSummaryList |% {$_.createdAt = (Get-Date 01.01.1970)+([System.TimeSpan]::fromseconds( $_.createdAt/1000))}
```

## Resources

