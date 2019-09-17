StopEC2InstanceMonthly

how to deploy it on AWS_lambda

```Powershell
$ Import-Module AWSLambdaPSCore 
$ Import-Module AWSPowershell

$ Initialize-AWSDefaults
$ Publish-AWSPowershellLambda -ScriptPath .\StopEC2InstanceMonthly.ps1 -Name StopEC2InstanceMonthly -Region ap-northeast-1
```