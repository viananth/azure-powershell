<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    Removes the specified plan

.DESCRIPTION
    Removes the specified plan

.PARAMETER Name
    Name of the plan.

.PARAMETER ResourceId
    The resource id.

.PARAMETER ResourceGroup
    The resource group the resource is located under.

.PARAMETER InputObject
    The input object of type Microsoft.AzureStack.Management.Subscriptions.Admin.Models.Plan.

.EXAMPLE
    Remove-AzsPlan -Name plan1 -ResourceGroupName "rg1"
#>
function Remove-AzsPlan
{
    [CmdletBinding(DefaultParameterSetName='Plans_Delete')]
    param(
        [Parameter(Mandatory = $true, ParameterSetName = 'Plans_Delete')]
        [System.String]
        $Name,

        [Parameter(Mandatory = $true, ParameterSetName = 'ResourceId_Plans_Delete')]
        [Parameter(Mandatory = $true, ParameterSetName = 'Plans_Delete')]
        [Parameter(Mandatory = $true, ParameterSetName = 'InputObject_Plans_Delete')]
        [System.String]
        $ResourceGroupName,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'ResourceId_Plans_Delete')]
        [System.String]
        $ResourceId,

        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'InputObject_Plans_Delete')]
        [Microsoft.AzureStack.Management.Subscriptions.Admin.Models.Plan]
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


    if('InputObject_Plans_Delete' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_Plans_Delete' -eq $PsCmdlet.ParameterSetName) {
        $GetArmResourceIdParameterValue_params = @{
            IdTemplate = '/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.Subscriptions.Admin/plans/{plan}'
        }

        if('ResourceId_Plans_Delete' -eq $PsCmdlet.ParameterSetName) {
            $GetArmResourceIdParameterValue_params['Id'] = $ResourceId
        }
        else {
            $GetArmResourceIdParameterValue_params['Id'] = $InputObject.Id
        }
        $ArmResourceIdParameterValues = Get-ArmResourceIdParameterValue @GetArmResourceIdParameterValue_params
        $resourceGroupName = $ArmResourceIdParameterValues['resourceGroupName']

        $plan = $ArmResourceIdParameterValues['plan']
    }


    if ('Plans_Delete' -eq $PsCmdlet.ParameterSetName -or 'InputObject_Plans_Delete' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_Plans_Delete' -eq $PsCmdlet.ParameterSetName) {
        Write-Verbose -Message 'Performing operation DeleteWithHttpMessagesAsync on $SubscriptionsAdminClient.'
        $TaskResult = $SubscriptionsAdminClient.Plans.DeleteWithHttpMessagesAsync($ResourceGroupName, $Plan)
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

