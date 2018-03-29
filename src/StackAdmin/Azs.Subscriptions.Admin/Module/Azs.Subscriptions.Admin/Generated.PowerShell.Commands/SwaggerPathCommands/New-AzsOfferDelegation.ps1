<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    Create a new offer delegation.

.DESCRIPTION
    Create a new offer delegation.

.PARAMETER OfferName
    Name of an offer.

.PARAMETER SubscriptionId
    Identifier of the subscription receiving the delegated offer.

.PARAMETER Name
    Name of a offer delegation.

.PARAMETER ResourceGroup
    The resource group the resource is located under.

.PARAMETER Location
    Location of the resource.

.EXAMPLE

    PS C:\> New-AzsOfferDelegation -Offer offer1 -ResourceGroupName rg1 -Name delegate1 -SubscriptionId "c90173b1-de7a-4b1d-8600-b832b0e65946" -Location "local"

    SubscriptionId : c90173b1-de7a-4b1d-8600-b832b0e65946
    Id             : /subscriptions/0a823c45-d9e7-4812-a138-74e22213693a/resourceGroups/rg1/providers/Microsoft.Subscriptions.Admin/offers/offer1/offerDelegations/delegate1
    Name           : offer1/delegate1
    Type           : Microsoft.Subscriptions.Admin/offers/offerDelegations
    Location       : local
    Tags           :

    Create a new offer delegation.

#>
function New-AzsOfferDelegation {
    [OutputType([Microsoft.AzureStack.Management.Subscriptions.Admin.Models.OfferDelegation])]
    [CmdletBinding(DefaultParameterSetName = 'Create')]
    param(
        [Parameter(Mandatory = $true, ParameterSetName = 'Create')]
        [string]
        $Name,

        [Parameter(Mandatory = $true, ParameterSetName = 'Create')]
        [System.String]
        $OfferName,

        [Parameter(Mandatory = $true, ParameterSetName = 'Create')]
        [string]
        $SubscriptionId,

        [Parameter(Mandatory = $true, ParameterSetName = 'Create')]
        [ValidateLength(1, 90)]
        [System.String]
        $ResourceGroupName,

        [Parameter(Mandatory = $false, ParameterSetName = 'Create')]
        [string]
        $Location
    )

    Begin {
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

        #$GlobalParameterHashtable['SubscriptionId'] = $null
        #if($PSBoundParameters.ContainsKey('SubscriptionId')) {
        #    $GlobalParameterHashtable['SubscriptionId'] = $PSBoundParameters['SubscriptionId']
        #}

        $SubscriptionsAdminClient = New-ServiceClient @NewServiceClient_params

        if (-not $PSBoundParameters.ContainsKey('Location')) {
            $Location = (Get-AzureRMLocation).Location
            $PSBoundParameters.Add("Location", $Location)
        }

        $flattenedParameters = @('SubscriptionId', 'Location')
        $utilityCmdParams = @{}
        $flattenedParameters | ForEach-Object {
            if ($PSBoundParameters.ContainsKey($_)) {
                $utilityCmdParams[$_] = $PSBoundParameters[$_]
            }
        }
        $NewOfferDelegation = New-OfferDelegationObject @utilityCmdParams

        $OfferDelegationName = $Name

        if ('Create' -eq $PsCmdlet.ParameterSetName) {
            Write-Verbose -Message 'Performing operation CreateOrUpdateWithHttpMessagesAsync on $SubscriptionsAdminClient.'
            $TaskResult = $SubscriptionsAdminClient.OfferDelegations.CreateOrUpdateWithHttpMessagesAsync($ResourceGroupName, $OfferName, $OfferDelegationName, $NewOfferDelegation)
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
