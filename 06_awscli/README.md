# README

Demonstrate how to use AWS cli and parse answers with `powershell`.  

Use [Shell Examples/32_awscli](https://github.com/chrisguest75/shell_examples/tree/master/33_awscli) as reference.  

TODO:  

* Find the container parameters for the job (mem, cpu, image)
* Get other data (running time, etc)  

## Scripts

### Show Queues

```sh
./show-queues.ps1 -showqueues      
```

### Jobs and Logs

The scripts allow quick interogration of AWS Batch logs.  

```sh
# show the list of queues 
./extract-failed-batch-logs.ps1 -showqueues    

# get failed jobs for a queue
./extract-failed-batch-logs.ps1 -failedjobs -queue my-queue
# or
./extract-failed-batch-logs.ps1 -failedjobs -queue my-queue

# take jobid from failed jobs and get streams
./extract-failed-batch-logs.ps1 -logstreams -jobid 5c1cee8f-b623-4b86-abae-00000000

# take the logstream id and print out the logs. 
./extract-failed-batch-logs.ps1 -logs -streamid my-queue/default/7ba44287e4cb468fa1fcd1c700000000
```

## Export All

Export all the failed logs into a folder

```sh
./extract-all-failed-batch-logs.ps1 -export -queue my-queue
```

## Process Batch Failures

Finds failures in batch queues and converts timestamp to human-readable datetime.  

```ps1
# get jobs as an array of objects
$queue = "batch-queue-name"
$failed = (aws --profile (Get-ChildItem -Path Env:\AWS_PROFILE).value --region (Get-ChildItem -Path Env:\AWS_REGION).value batch list-jobs --job-queue $queue --job-status FAILED | ConvertFrom-Json)
$failed.jobSummaryList

# filter fields we don't need and convert createdAt timestamp to string. 
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

Use the `$failedfiltered` and find the logstreams

```ps1
# take multiple attempts for failed jobs 
$failedjobs = $failedfiltered | % { aws --profile (Get-ChildItem -Path Env:\AWS_PROFILE).value --region (Get-ChildItem -Path Env:\AWS_REGION).value batch describe-jobs --jobs $_.jobid | ConvertFrom-Json} 
$failedjobs
$attempts = $failedjobs.jobs | % {$_ | select-object -Property jobId,attempts}
$attempts

# extract the logstreams
$logstreams = $attempts | % {$_ | select-object -Property  jobId,@{
     label='logStreamName'
     expression={$_.attempts.container.logStreamName}}}
$logstreams

$logs = (aws --profile (Get-ChildItem -Path Env:\AWS_PROFILE).value --region  (Get-ChildItem -Path Env:\AWS_REGION).value logs get-log-events --log-group-name "/aws/batch/job" --log-stream-name $logstreams[0].logStreamName[0] | convertfrom-json)
$logs.events


```

## Resources

