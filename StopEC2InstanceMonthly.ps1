# PowerShell script file to be executed as a AWS Lambda function. 
# 
# When executing in Lambda the following variables will be predefined.
#   $LambdaInput - A PSObject that contains the Lambda function input data.
#   $LambdaContext - An Amazon.Lambda.Core.ILambdaContext object that contains information about the currently running Lambda environment.
#
# The last item in the PowerShell pipeline will be returned as the result of the Lambda function.
#
# To include PowerShell modules with your Lambda function, like the AWSPowerShell.NetCore module, add a "#Requires" statement 
# indicating the module and version.

#Requires -Modules @{ModuleName='AWSPowerShell.NetCore';ModuleVersion='3.3.563.1'}

# Uncomment to send the input event to CloudWatch Logs
# Write-Host (ConvertTo-Json -InputObject $LambdaInput -Compress -Depth 5)

Write-Host("start-script")
$awsRegions = Get-AWSRegion

foreach ($region in $awsRegions) {
    Write-Host("Current Region is $($region.Region)")
    $runningEC2Instances = get-ec2instance -Filter @{Name="instance-state-name";Value="running"} -Region $region.Region
    Write-Host("count of EC2 Instance in $($region.Region) is $($runningEC2Instances.count)")

    foreach ($instance in $runningEC2Instances) {
        $idx = $Instance.Instances.Tag.Key.IndexOf("Name")
        $instanceLabel = $Instance.Instances.Tag.Value[$idx]

        Write-Host("Run : Stop-EC2Instance -InstanceId $($instance.Instances.InstanceId)")
        Stop-EC2Instance -InstanceId $instance.Instances.InstanceId
        Write-Host("Stopping $($instance.Instances.InstanceId) as ${instanceLabel}")
    }
}

Write-Host("script done")    
