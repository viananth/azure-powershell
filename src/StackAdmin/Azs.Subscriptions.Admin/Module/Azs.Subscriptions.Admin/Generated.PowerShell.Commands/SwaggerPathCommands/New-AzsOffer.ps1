<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS


.DESCRIPTION
    Create or update the offer.

.PARAMETER Name
    Name of an offer.

.PARAMETER MaxSubscriptionsPerAccount
    Maximum subscriptions per account.

.PARAMETER DisplayName
    Display name of offer.

.PARAMETER ResourceId
    The resource id.

.PARAMETER BasePlanIds
    Identifiers of the base plans that become available to the tenant immediately when a tenant subscribes to the offer.

.PARAMETER InputObject
    The input object of type Microsoft.AzureStack.Management.Subscriptions.Admin.Models.Offer.

.PARAMETER Description
    Description of offer.

.PARAMETER ResourceGroup
    The resource group the resource is located under.

.PARAMETER ExternalReferenceId
    External reference identifier.

.PARAMETER State
    Offer accessibility state.

.PARAMETER Location
    Location where resource is location.

.PARAMETER SubscriptionCount
    Current subscription count.

.PARAMETER AddonPlanDefinition
    References to add-on plans that a tenant can optionally acquire as a part of the offer.

#>
function New-AzsOffer
{
    [OutputType([Microsoft.AzureStack.Management.Subscriptions.Admin.Models.Offer])]
    [CmdletBinding(DefaultParameterSetName='Offers_CreateOrUpdate')]
    param(
        [Parameter(Mandatory = $true, ParameterSetName = 'Offers_CreateOrUpdate')]
        [System.String]
        $Name,

        [Parameter(Mandatory = $false, ParameterSetName = 'ResourceId_Offers_CreateOrUpdate')]
        [Parameter(Mandatory = $false, ParameterSetName = 'InputObject_Offers_CreateOrUpdate')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Offers_CreateOrUpdate')]
        [int64]
        $MaxSubscriptionsPerAccount,

        [Parameter(Mandatory = $false, ParameterSetName = 'ResourceId_Offers_CreateOrUpdate')]
        [Parameter(Mandatory = $false, ParameterSetName = 'InputObject_Offers_CreateOrUpdate')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Offers_CreateOrUpdate')]
        [string]
        $DisplayName,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'ResourceId_Offers_CreateOrUpdate')]
        [System.String]
        $ResourceId,

        [Parameter(Mandatory = $false, ParameterSetName = 'ResourceId_Offers_CreateOrUpdate')]
        [Parameter(Mandatory = $false, ParameterSetName = 'InputObject_Offers_CreateOrUpdate')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Offers_CreateOrUpdate')]
        [string[]]
        $BasePlanIds,

        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'InputObject_Offers_CreateOrUpdate')]
        [Microsoft.AzureStack.Management.Subscriptions.Admin.Models.Offer]
        $InputObject,

        [Parameter(Mandatory = $false, ParameterSetName = 'ResourceId_Offers_CreateOrUpdate')]
        [Parameter(Mandatory = $false, ParameterSetName = 'InputObject_Offers_CreateOrUpdate')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Offers_CreateOrUpdate')]
        [string]
        $Description,

        [Parameter(Mandatory = $true, ParameterSetName = 'ResourceId_Offers_CreateOrUpdate')]
        [Parameter(Mandatory = $true, ParameterSetName = 'InputObject_Offers_CreateOrUpdate')]
        [Parameter(Mandatory = $true, ParameterSetName = 'Offers_CreateOrUpdate')]
        [System.String]
        $ResourceGroupName,

        [Parameter(Mandatory = $false, ParameterSetName = 'ResourceId_Offers_CreateOrUpdate')]
        [Parameter(Mandatory = $false, ParameterSetName = 'InputObject_Offers_CreateOrUpdate')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Offers_CreateOrUpdate')]
        [string]
        $ExternalReferenceId,

        [Parameter(Mandatory = $false, ParameterSetName = 'ResourceId_Offers_CreateOrUpdate')]
        [Parameter(Mandatory = $false, ParameterSetName = 'InputObject_Offers_CreateOrUpdate')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Offers_CreateOrUpdate')]
        [ValidateSet('Private', 'Public', 'Decommissioned')]
        [string]
        $State,

        [Parameter(Mandatory = $false, ParameterSetName = 'ResourceId_Offers_CreateOrUpdate')]
        [Parameter(Mandatory = $false, ParameterSetName = 'InputObject_Offers_CreateOrUpdate')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Offers_CreateOrUpdate')]
        [string]
        $Location,

        [Parameter(Mandatory = $false, ParameterSetName = 'ResourceId_Offers_CreateOrUpdate')]
        [Parameter(Mandatory = $false, ParameterSetName = 'InputObject_Offers_CreateOrUpdate')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Offers_CreateOrUpdate')]
        [int64]
        $SubscriptionCount,

        [Parameter(Mandatory = $false, ParameterSetName = 'ResourceId_Offers_CreateOrUpdate')]
        [Parameter(Mandatory = $false, ParameterSetName = 'InputObject_Offers_CreateOrUpdate')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Offers_CreateOrUpdate')]
        [Microsoft.AzureStack.Management.Subscriptions.Admin.Models.AddonPlanDefinition[]]
        $AddonPlanDefinition
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


    $flattenedParameters = @('MaxSubscriptionsPerAccount', 'BasePlanIds', 'DisplayName', 'Description', 'ExternalReferenceId', 'State', 'Location', 'SubscriptionCount', 'AddonPlanDefinition')
    $utilityCmdParams = @{}
    $flattenedParameters | ForEach-Object {
        if($PSBoundParameters.ContainsKey($_)) {
            $utilityCmdParams[$_] = $PSBoundParameters[$_]
        }
    }
    $NewOffer = New-OfferObject @utilityCmdParams


    $Offer = $Name


    if('InputObject_Offers_CreateOrUpdate' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_Offers_CreateOrUpdate' -eq $PsCmdlet.ParameterSetName) {
        $GetArmResourceIdParameterValue_params = @{
            IdTemplate = '/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.Subscriptions.Admin/offers/{offer}'
        }

        if('ResourceId_Offers_CreateOrUpdate' -eq $PsCmdlet.ParameterSetName) {
            $GetArmResourceIdParameterValue_params['Id'] = $ResourceId
        }
        else {
            $GetArmResourceIdParameterValue_params['Id'] = $InputObject.Id
        }
        $ArmResourceIdParameterValues = Get-ArmResourceIdParameterValue @GetArmResourceIdParameterValue_params
        $resourceGroupName = $ArmResourceIdParameterValues['resourceGroupName']

        $offer = $ArmResourceIdParameterValues['offer']
    } elseif (-not $PSBoundParameters.ContainsKey('Location'))
    {
         $Location = (Get-AzureRMLocation).Location
    }


    if ('Offers_CreateOrUpdate' -eq $PsCmdlet.ParameterSetName -or 'InputObject_Offers_CreateOrUpdate' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_Offers_CreateOrUpdate' -eq $PsCmdlet.ParameterSetName) {
        Write-Verbose -Message 'Performing operation CreateOrUpdateWithHttpMessagesAsync on $SubscriptionsAdminClient.'
        $TaskResult = $SubscriptionsAdminClient.Offers.CreateOrUpdateWithHttpMessagesAsync($ResourceGroupName, $Offer, $NewOffer)
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

