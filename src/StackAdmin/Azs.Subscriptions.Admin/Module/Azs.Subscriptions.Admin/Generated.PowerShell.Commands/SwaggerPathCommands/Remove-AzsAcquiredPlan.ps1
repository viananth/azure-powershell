<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    Deletes an acquired plan.

.DESCRIPTION
    Deletes an acquired plan.

.PARAMETER Name
    The plan acquisition Identifier

.PARAMETER ResourceId
    The resource id.

.PARAMETER InputObject
    The input object of type Microsoft.AzureStack.Management.Subscriptions.Admin.Models.PlanAcquisition.

.PARAMETER TargetSubscriptionId
    The target subscription ID.

#>
function Remove-AzsAcquiredPlan
{
    [CmdletBinding(DefaultParameterSetName='AcquiredPlans_Delete')]
    param(
        [Parameter(Mandatory = $true, ParameterSetName = 'AcquiredPlans_Delete')]
        [string]
        $Name,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'ResourceId_AcquiredPlans_Delete')]
        [System.String]
        $ResourceId,

        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'InputObject_AcquiredPlans_Delete')]
        [Microsoft.AzureStack.Management.Subscriptions.Admin.Models.PlanAcquisition]
        $InputObject,

        [Parameter(Mandatory = $true, ParameterSetName = 'AcquiredPlans_Delete')]
        [string]
        $TargetSubscriptionId
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

    $PlanAcquisitionId = $Name


    if('InputObject_AcquiredPlans_Delete' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_AcquiredPlans_Delete' -eq $PsCmdlet.ParameterSetName) {
        $GetArmResourceIdParameterValue_params = @{
            IdTemplate = '/subscriptions/{subscriptionId}/providers/Microsoft.Subscriptions.Admin/subscriptions/{targetSubscriptionId}/acquiredPlans/{planAcquisitionId}'
        }

        if('ResourceId_AcquiredPlans_Delete' -eq $PsCmdlet.ParameterSetName) {
            $GetArmResourceIdParameterValue_params['Id'] = $ResourceId
        }
        else {
            $GetArmResourceIdParameterValue_params['Id'] = $InputObject.Id
        }
        $ArmResourceIdParameterValues = Get-ArmResourceIdParameterValue @GetArmResourceIdParameterValue_params
        $targetSubscriptionId = $ArmResourceIdParameterValues['targetSubscriptionId']

        $planAcquisitionId = $ArmResourceIdParameterValues['planAcquisitionId']
    }


    if ('AcquiredPlans_Delete' -eq $PsCmdlet.ParameterSetName -or 'InputObject_AcquiredPlans_Delete' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_AcquiredPlans_Delete' -eq $PsCmdlet.ParameterSetName) {
        Write-Verbose -Message 'Performing operation DeleteWithHttpMessagesAsync on $SubscriptionsAdminClient.'
        $TaskResult = $SubscriptionsAdminClient.AcquiredPlans.DeleteWithHttpMessagesAsync()
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

