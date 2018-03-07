<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    Get the offer metrics.

.DESCRIPTION
    Get the offer metrics.

.PARAMETER ResourceGroup
    The resource group the resource is located under.

.PARAMETER OfferName
    Name of an offer.

.EXAMPLE
PS C:\> Get-AzsOfferMetric -ResourceGroupName rg1 -Offer offername1 | fl *

Value    : {Microsoft.AzureStack.Management.Subscriptions.Admin.Models.Metric, Microsoft.AzureStack.Management.Subscriptions.Admin.Models.Metric}
NextLink : 

#>
function Get-AzsOfferMetric
{
    [OutputType([Microsoft.AzureStack.Management.Subscriptions.Admin.Models.Metric])]
    [CmdletBinding(DefaultParameterSetName='Offers_ListMetrics')]
    param(
        [Parameter(Mandatory = $true, ParameterSetName = 'Offers_ListMetrics')]
        [System.String]
        $OfferName,

        [Parameter(Mandatory = $true, ParameterSetName = 'Offers_ListMetrics')]
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


    if ('Offers_ListMetrics' -eq $PsCmdlet.ParameterSetName) {
        Write-Verbose -Message 'Performing operation ListMetricsWithHttpMessagesAsync on $SubscriptionsAdminClient.'
        $TaskResult = $SubscriptionsAdminClient.Offers.ListMetricsWithHttpMessagesAsync($ResourceGroupName, $OfferName)
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

