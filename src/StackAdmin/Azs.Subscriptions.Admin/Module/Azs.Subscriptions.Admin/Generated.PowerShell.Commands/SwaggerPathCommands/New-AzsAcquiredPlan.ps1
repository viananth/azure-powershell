<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    

.DESCRIPTION
    Creates an acquired plan.

.PARAMETER ProvisioningState
    State of the provisioning.

.PARAMETER AcquisitionTime
    Acquisition time.

.PARAMETER Id
    Identifier in the tenant subscription context.

.PARAMETER ResourceId
    The resource id.

.PARAMETER PlanId
    Plan identifier in the tenant subscription context.

.PARAMETER InputObject
    The input object of type Microsoft.AzureStack.Management.Subscriptions.Admin.Models.PlanAcquisition.

.PARAMETER AcquisitionId
    Acquisition identifier.

.PARAMETER Name
    The plan acquisition Identifier

.PARAMETER TargetSubscriptionId
    The target subscription ID.

.PARAMETER ExternalReferenceId
    External reference identifier.

#>
function New-AzsAcquiredPlan
{
    [OutputType([Microsoft.AzureStack.Management.Subscriptions.Admin.Models.PlanAcquisition])]
    [CmdletBinding(DefaultParameterSetName='AcquiredPlans_Create')]
    param(    
        [Parameter(Mandatory = $false, ParameterSetName = 'InputObject_AcquiredPlans_Create')]
        [Parameter(Mandatory = $false, ParameterSetName = 'ResourceId_AcquiredPlans_Create')]
        [Parameter(Mandatory = $false, ParameterSetName = 'AcquiredPlans_Create')]
        [ValidateSet('NotSpecified', 'Accepted', 'Failed', 'Succeeded')]
        [string]
        $ProvisioningState,
    
        [Parameter(Mandatory = $false, ParameterSetName = 'InputObject_AcquiredPlans_Create')]
        [Parameter(Mandatory = $false, ParameterSetName = 'ResourceId_AcquiredPlans_Create')]
        [Parameter(Mandatory = $false, ParameterSetName = 'AcquiredPlans_Create')]
        [string]
        $AcquisitionTime,
    
        [Parameter(Mandatory = $false, ParameterSetName = 'InputObject_AcquiredPlans_Create')]
        [Parameter(Mandatory = $false, ParameterSetName = 'ResourceId_AcquiredPlans_Create')]
        [Parameter(Mandatory = $false, ParameterSetName = 'AcquiredPlans_Create')]
        [string]
        $Id,
    
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'ResourceId_AcquiredPlans_Create')]
        [System.String]
        $ResourceId,
    
        [Parameter(Mandatory = $false, ParameterSetName = 'InputObject_AcquiredPlans_Create')]
        [Parameter(Mandatory = $false, ParameterSetName = 'ResourceId_AcquiredPlans_Create')]
        [Parameter(Mandatory = $false, ParameterSetName = 'AcquiredPlans_Create')]
        [string]
        $PlanId,
    
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'InputObject_AcquiredPlans_Create')]
        [Microsoft.AzureStack.Management.Subscriptions.Admin.Models.PlanAcquisition]
        $InputObject,
    
        [Parameter(Mandatory = $false, ParameterSetName = 'InputObject_AcquiredPlans_Create')]
        [Parameter(Mandatory = $false, ParameterSetName = 'ResourceId_AcquiredPlans_Create')]
        [Parameter(Mandatory = $false, ParameterSetName = 'AcquiredPlans_Create')]
        [string]
        $AcquisitionId,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'AcquiredPlans_Create')]
        [Alias('PlanAcquisitionId')]
        [string]
        $Name,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'AcquiredPlans_Create')]
        [string]
        $TargetSubscriptionId,
    
        [Parameter(Mandatory = $false, ParameterSetName = 'InputObject_AcquiredPlans_Create')]
        [Parameter(Mandatory = $false, ParameterSetName = 'ResourceId_AcquiredPlans_Create')]
        [Parameter(Mandatory = $false, ParameterSetName = 'AcquiredPlans_Create')]
        [string]
        $ExternalReferenceId
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

        
    $flattenedParameters = @('ProvisioningState', 'AcquisitionTime', 'Id', 'PlanId', 'AcquisitionId', 'ExternalReferenceId')
    $utilityCmdParams = @{}
    $flattenedParameters | ForEach-Object {
        if($PSBoundParameters.ContainsKey($_)) {
            $utilityCmdParams[$_] = $PSBoundParameters[$_]
        }
    }
    $NewAcquiredPlan = New-PlanAcquisitionPropertiesObject @utilityCmdParams

 
    $PlanAcquisitionId = $Name

 
    if('InputObject_AcquiredPlans_Create' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_AcquiredPlans_Create' -eq $PsCmdlet.ParameterSetName) {
        $GetArmResourceIdParameterValue_params = @{
            IdTemplate = '/subscriptions/{subscriptionId}/providers/Microsoft.Subscriptions.Admin/subscriptions/{targetSubscriptionId}/acquiredPlans/{planAcquisitionId}'
        }

        if('ResourceId_AcquiredPlans_Create' -eq $PsCmdlet.ParameterSetName) {
            $GetArmResourceIdParameterValue_params['Id'] = $ResourceId
        }
        else {
            $GetArmResourceIdParameterValue_params['Id'] = $InputObject.Id
        }
        $ArmResourceIdParameterValues = Get-ArmResourceIdParameterValue @GetArmResourceIdParameterValue_params
        $targetSubscriptionId = $ArmResourceIdParameterValues['targetSubscriptionId']

        $planAcquisitionId = $ArmResourceIdParameterValues['planAcquisitionId']
    }


    if ('AcquiredPlans_Create' -eq $PsCmdlet.ParameterSetName -or 'InputObject_AcquiredPlans_Create' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_AcquiredPlans_Create' -eq $PsCmdlet.ParameterSetName) {
        Write-Verbose -Message 'Performing operation CreateWithHttpMessagesAsync on $SubscriptionsAdminClient.'
        $TaskResult = $SubscriptionsAdminClient.AcquiredPlans.CreateWithHttpMessagesAsync($NewAcquiredPlan)
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

