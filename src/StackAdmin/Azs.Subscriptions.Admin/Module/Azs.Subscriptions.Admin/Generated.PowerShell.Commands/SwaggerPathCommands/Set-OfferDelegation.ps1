<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    

.DESCRIPTION
    Get the list of offers.

.PARAMETER ResourceId
    The resource id.

.PARAMETER Offer
    Name of an offer.

.PARAMETER Name
    Name of a delgated offer.

.PARAMETER ResourceGroup
    The resource group the resource is located under.

.PARAMETER InputObject
    The input object of type Microsoft.AzureStack.Management.Subscriptions.Admin.Models.DelegatedOffer.

.PARAMETER NewDelegatedOffer
    New delegated offer.

#>
function Set-OfferDelegation
{
    [OutputType([Microsoft.AzureStack.Management.Subscriptions.Admin.Models.DelegatedOffer])]
    [CmdletBinding(DefaultParameterSetName='OfferDelegations_CreateOrUpdate')]
    param(    
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'ResourceId_OfferDelegations_CreateOrUpdate')]
        [System.String]
        $ResourceId,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'OfferDelegations_CreateOrUpdate')]
        [System.String]
        $Offer,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'OfferDelegations_CreateOrUpdate')]
        [Alias('DelegatedOffer')]
        [System.String]
        $Name,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'OfferDelegations_CreateOrUpdate')]
        [System.String]
        $ResourceGroup,
    
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'InputObject_OfferDelegations_CreateOrUpdate')]
        [Microsoft.AzureStack.Management.Subscriptions.Admin.Models.DelegatedOffer]
        $InputObject,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'OfferDelegations_CreateOrUpdate')]
        [Parameter(Mandatory = $true, ParameterSetName = 'ResourceId_OfferDelegations_CreateOrUpdate')]
        [Parameter(Mandatory = $true, ParameterSetName = 'InputObject_OfferDelegations_CreateOrUpdate')]
        [Microsoft.AzureStack.Management.Subscriptions.Admin.Models.DelegatedOffer]
        $NewDelegatedOffer
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

    $DelegatedOffer = $Name

 
    if('InputObject_OfferDelegations_CreateOrUpdate' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_OfferDelegations_CreateOrUpdate' -eq $PsCmdlet.ParameterSetName) {
        $GetArmResourceIdParameterValue_params = @{
            IdTemplate = '/subscriptions/{subscriptionId}/resourcegroups/{resourceGroup}/providers/Microsoft.Subscriptions.Admin/offers/{offer}/offerDelegations/{delegatedOffer}'
        }

        if('ResourceId_OfferDelegations_CreateOrUpdate' -eq $PsCmdlet.ParameterSetName) {
            $GetArmResourceIdParameterValue_params['Id'] = $ResourceId
        }
        else {
            $GetArmResourceIdParameterValue_params['Id'] = $InputObject.Id
        }
        $ArmResourceIdParameterValues = Get-ArmResourceIdParameterValue @GetArmResourceIdParameterValue_params
        $resourceGroup = $ArmResourceIdParameterValues['resourceGroup']

        $offer = $ArmResourceIdParameterValues['offer']

        $delegatedOffer = $ArmResourceIdParameterValues['delegatedOffer']
    }


    if ('OfferDelegations_CreateOrUpdate' -eq $PsCmdlet.ParameterSetName -or 'InputObject_OfferDelegations_CreateOrUpdate' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_OfferDelegations_CreateOrUpdate' -eq $PsCmdlet.ParameterSetName) {
        Write-Verbose -Message 'Performing operation CreateOrUpdateWithHttpMessagesAsync on $SubscriptionsAdminClient.'
        $TaskResult = $SubscriptionsAdminClient.OfferDelegations.CreateOrUpdateWithHttpMessagesAsync($ResourceGroup, $Offer, $DelegatedOffer, $NewDelegatedOffer)
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

