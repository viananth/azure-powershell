<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    Get the list of plan metric definitions.

.DESCRIPTION
    Get the list of plan metric definitions.

.PARAMETER ResourceGroup
    The resource group the resource is located under.

.PARAMETER Plan
    Name of the plan.

#>
function Get-AzsPlanMetricDefinition
{
    [OutputType([Microsoft.AzureStack.Management.Subscriptions.Admin.Models.MetricDefinition])]
    [CmdletBinding(DefaultParameterSetName='Plans_ListMetricDefinitions')]
    param(
        [Parameter(Mandatory = $true, ParameterSetName = 'Plans_ListMetricDefinitions')]
        [System.String]
        $PlanName,

        [Parameter(Mandatory = $true, ParameterSetName = 'Plans_ListMetricDefinitions')]
        [System.String]
        $ResourceGroupName
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


    if ('Plans_ListMetricDefinitions' -eq $PsCmdlet.ParameterSetName) {
        Write-Verbose -Message 'Performing operation ListMetricDefinitionsWithHttpMessagesAsync on $SubscriptionsAdminClient.'
        $TaskResult = $SubscriptionsAdminClient.Plans.ListMetricDefinitionsWithHttpMessagesAsync($ResourceGroupName, $PlanName)
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

