<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    

.DESCRIPTION
    Creates an acquired plan.

.PARAMETER TargetSubscription
    The target subscription.

.PARAMETER ResourceId
    The resource id.

.PARAMETER Name
    Name of the plan.

.PARAMETER NewAcquiredPlan
    The new acquired plan.

.PARAMETER InputObject
    The input object of type Microsoft.AzureStack.Management.Subscriptions.Admin.Models.AcquiredPlan.

#>
function New-AcquiredPlan
{
    [OutputType([Microsoft.AzureStack.Management.Subscriptions.Admin.Models.AcquiredPlan])]
    [CmdletBinding(DefaultParameterSetName='AcquiredPlans_Create')]
    param(    
        [Parameter(Mandatory = $true, ParameterSetName = 'InputObject_AcquiredPlans_Create')]
        [Parameter(Mandatory = $true, ParameterSetName = 'ResourceId_AcquiredPlans_Create')]
        [Parameter(Mandatory = $true, ParameterSetName = 'AcquiredPlans_Create')]
        [System.String]
        $TargetSubscription,
    
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'ResourceId_AcquiredPlans_Create')]
        [System.String]
        $ResourceId,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'AcquiredPlans_Create')]
        [Alias('Plan')]
        [System.String]
        $Name,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'InputObject_AcquiredPlans_Create')]
        [Parameter(Mandatory = $true, ParameterSetName = 'ResourceId_AcquiredPlans_Create')]
        [Parameter(Mandatory = $true, ParameterSetName = 'AcquiredPlans_Create')]
        [Microsoft.AzureStack.Management.Subscriptions.Admin.Models.AcquiredPlanProperties]
        $NewAcquiredPlan,
    
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'InputObject_AcquiredPlans_Create')]
        [Microsoft.AzureStack.Management.Subscriptions.Admin.Models.AcquiredPlan]
        $InputObject
    )

    Begin 
    {
	    Initialize-PSSwaggerDependencies -Azure
        $tracerObject = $null
        if (('continue' -eq $DebugPreference) -or ('inquire' -eq $DebugPreference)) {
            $oldDebugPreference = $global:DebugPreference
			$global:DebugPreference = "continue"
            $tracerObject = New-PSSwaggerClientTracing
            Register-PSSwaggerClientTracing -TracerObject $tracerObject
        }
	}

    Process {
    
    $ErrorActionPreference = 'Stop'

    $NewServiceClient_params = @{
        FullClientTypeName = 'Microsoft.AzureStack.Management.Subscriptions.Admin.SubscriptionsAdminClient'
    }

    $GlobalParameterHashtable = @{}
    $NewServiceClient_params['GlobalParameterHashtable'] = $GlobalParameterHashtable
     
    $GlobalParameterHashtable['SubscriptionId'] = $null
    if($PSBoundParameters.ContainsKey('SubscriptionId')) {
        $GlobalParameterHashtable['SubscriptionId'] = $PSBoundParameters['SubscriptionId']
    }

    $SubscriptionsAdminClient = New-ServiceClient @NewServiceClient_params

    $Plan = $Name

 
    if('InputObject_AcquiredPlans_Create' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_AcquiredPlans_Create' -eq $PsCmdlet.ParameterSetName) {
        $GetArmResourceIdParameterValue_params = @{
            IdTemplate = '/subscriptions/{subscriptionId}/providers/Microsoft.Subscriptions.Admin/subscriptions/{targetSubscriptionId}/acquiredPlans/{plan}'
        }

        if('ResourceId_AcquiredPlans_Create' -eq $PsCmdlet.ParameterSetName) {
            $GetArmResourceIdParameterValue_params['Id'] = $ResourceId
        }
        else {
            $GetArmResourceIdParameterValue_params['Id'] = $InputObject.Id
        }
        $ArmResourceIdParameterValues = Get-ArmResourceIdParameterValue @GetArmResourceIdParameterValue_params
        $targetSubscriptionId = $ArmResourceIdParameterValues['targetSubscriptionId']

        $plan = $ArmResourceIdParameterValues['plan']
    }


    if ('AcquiredPlans_Create' -eq $PsCmdlet.ParameterSetName -or 'InputObject_AcquiredPlans_Create' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_AcquiredPlans_Create' -eq $PsCmdlet.ParameterSetName) {
        Write-Verbose -Message 'Performing operation CreateWithHttpMessagesAsync on $SubscriptionsAdminClient.'
        $TaskResult = $SubscriptionsAdminClient.AcquiredPlans.CreateWithHttpMessagesAsync($TargetSubscription, $Plan, $NewAcquiredPlan)
    } else {
        Write-Verbose -Message 'Failed to map parameter set to operation method.'
        throw 'Module failed to find operation to execute.'
    }

    if ($TaskResult) {
        $GetTaskResult_params = @{
            TaskResult = $TaskResult
        }
            
        Get-TaskResult @GetTaskResult_params
        
    }
    }

    End {
        if ($tracerObject) {
            $global:DebugPreference = $oldDebugPreference
            Unregister-PSSwaggerClientTracing -TracerObject $tracerObject
        }
    }
}

