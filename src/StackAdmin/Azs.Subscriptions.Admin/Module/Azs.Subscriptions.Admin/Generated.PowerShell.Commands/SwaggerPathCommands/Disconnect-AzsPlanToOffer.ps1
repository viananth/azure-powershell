<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    Unlink a plan from an offer.

.DESCRIPTION
    Unlink a plan from an offer.

.PARAMETER ResourceGroup
    The resource group the resource is located under.

.PARAMETER PlanLink
    New plan link.

.PARAMETER Offer
    Name of an offer.

#>
function Disconnect-AzsPlanToOffer
{
    [CmdletBinding(DefaultParameterSetName='Offers_Unlink')]
    param(
        [Parameter(Mandatory = $true, ParameterSetName = 'Offers_Unlink')]
        [System.String]
        $ResourceGroup,

        [Parameter(Mandatory = $true, ParameterSetName = 'Offers_Unlink')]
        [System.String]
        $PlanLink,

        [Parameter(Mandatory = $true, ParameterSetName = 'Offers_Unlink')]
        [System.String]
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


    if ('Offers_Unlink' -eq $PsCmdlet.ParameterSetName) {
        Write-Verbose -Message 'Performing operation UnlinkWithHttpMessagesAsync on $SubscriptionsAdminClient.'
        $TaskResult = $SubscriptionsAdminClient.Offers.UnlinkWithHttpMessagesAsync($ResourceGroup, $Offer, $PlanLink)
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

