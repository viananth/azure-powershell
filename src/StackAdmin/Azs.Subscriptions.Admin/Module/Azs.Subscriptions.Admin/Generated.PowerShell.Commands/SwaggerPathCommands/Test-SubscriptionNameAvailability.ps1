<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    Get the list of subscriptions.

.DESCRIPTION
    Get the list of subscriptions.

.PARAMETER Offer
    Check name availability parameter

#>
function Test-SubscriptionNameAvailability
{
    [OutputType([Microsoft.AzureStack.Management.Subscriptions.Admin.Models.CheckNameAvailabilityResponse])]
    [CmdletBinding(DefaultParameterSetName='Subscriptions_CheckNameAvailability')]
    param(
        [Parameter(Mandatory = $true, ParameterSetName = 'Subscriptions_CheckNameAvailability')]
        [Microsoft.AzureStack.Management.Subscriptions.Admin.Models.CheckNameAvailabilityDefinition]
        $Offer
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


    if ('Subscriptions_CheckNameAvailability' -eq $PsCmdlet.ParameterSetName) {
        Write-Verbose -Message 'Performing operation CheckNameAvailabilityWithHttpMessagesAsync on $SubscriptionsAdminClient.'
        $TaskResult = $SubscriptionsAdminClient.Subscriptions.CheckNameAvailabilityWithHttpMessagesAsync($Offer)
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

