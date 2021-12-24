# README

Demonstrate how to use AWS cli and parse answers with `powershell`.  

## Process Batch Failures

```ps1
$queue = "batch-queue-name"
$failed = (aws --profile (Get-ChildItem -Path Env:\AWS_PROFILE).value --region us-east-1 batch list-jobs --job-queue $queue --job-status FAILED | ConvertFrom-Json)
$failed.jobSummaryList

$failedfiltered = $failed.jobSummaryList | Select-Object -Property status,jobId,jobName,@{
    label='createdAt'
    expression={(Get-Date 01.01.1970)+([System.TimeSpan]::fromseconds( $_.createdAt/1000))}
  },@{
    label='reason'
    expression={$_.container.reason}}
$failedfiltered

## could also write it back out 
# $failed.jobSummaryList |% {$_.createdAt = (Get-Date 01.01.1970)+([System. TimeSpan]::fromseconds( $_.createdAt/1000))}
```

## Process Batch Log Events

```ps1
$failedjobs = $failedfiltered | % { aws --profile (Get-ChildItem -Path Env:\AWS_PROFILE).value --region us-east-1 batch describe-jobs --jobs $_.jobid | ConvertFrom-Json} 
$failedjobs
$attempts = $failedjobs.jobs | % {$_ | select-object -Property jobId,attempts}

$logstreams = $attempts | % {$_ | select-object -Property  jobId,@{
     label='logStreamName'
     expression={$_.attempts.container.logStreamName}}}

$logstreams | % { aws --profile (Get-ChildItem -Path Env:\AWS_PROFILE).value --region us-east-1 batch get-log-events --log-group-name "/aws/batch/job" --log-stream-name 

$logs = (aws --profile (Get-ChildItem -Path Env:\AWS_PROFILE).value --region us-east-1 logs get-log-events --log-group-name "/aws/batch/job" --log-stream-name $logstreams[0].logStreamName[0] | convertfrom-json)
$logs.events
```

## Resources

