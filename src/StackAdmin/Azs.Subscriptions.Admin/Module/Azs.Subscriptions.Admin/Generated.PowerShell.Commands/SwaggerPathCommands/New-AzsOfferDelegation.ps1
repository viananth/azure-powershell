<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    

.DESCRIPTION
    Get the list of offers.

.PARAMETER Id
    URI of the resource.

.PARAMETER Type
    Type of resource.

.PARAMETER Offer
    Name of an offer.

.PARAMETER Tags
    List of key-value pairs.

.PARAMETER SubscriptionId
    Identifier of the subscription receiving the delegated offer.

.PARAMETER Name
    Name of a offer delegation.

.PARAMETER ResourceId
    The resource id.

.PARAMETER ResourceGroup
    The resource group the resource is located under.

.PARAMETER Location
    Location where resource is location.

.PARAMETER InputObject
    The input object of type Microsoft.AzureStack.Management.Subscriptions.Admin.Models.OfferDelegation.

#>
function New-AzsOfferDelegation
{
    [OutputType([Microsoft.AzureStack.Management.Subscriptions.Admin.Models.OfferDelegation])]
    [CmdletBinding(DefaultParameterSetName='OfferDelegations_CreateOrUpdate')]
    param(    
        [Parameter(Mandatory = $false, ParameterSetName = 'OfferDelegations_CreateOrUpdate')]
        [Parameter(Mandatory = $false, ParameterSetName = 'ResourceId_OfferDelegations_CreateOrUpdate')]
        [Parameter(Mandatory = $false, ParameterSetName = 'InputObject_OfferDelegations_CreateOrUpdate')]
        [string]
        $Id,
    
        [Parameter(Mandatory = $false, ParameterSetName = 'OfferDelegations_CreateOrUpdate')]
        [Parameter(Mandatory = $false, ParameterSetName = 'ResourceId_OfferDelegations_CreateOrUpdate')]
        [Parameter(Mandatory = $false, ParameterSetName = 'InputObject_OfferDelegations_CreateOrUpdate')]
        [string]
        $Type,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'OfferDelegations_CreateOrUpdate')]
        [System.String]
        $Offer,
    
        [Parameter(Mandatory = $false, ParameterSetName = 'OfferDelegations_CreateOrUpdate')]
        [Parameter(Mandatory = $false, ParameterSetName = 'ResourceId_OfferDelegations_CreateOrUpdate')]
        [Parameter(Mandatory = $false, ParameterSetName = 'InputObject_OfferDelegations_CreateOrUpdate')]
        [System.Collections.Generic.Dictionary[[string],[string]]]
        $Tags,
    
        [Parameter(Mandatory = $false, ParameterSetName = 'OfferDelegations_CreateOrUpdate')]
        [Parameter(Mandatory = $false, ParameterSetName = 'ResourceId_OfferDelegations_CreateOrUpdate')]
        [Parameter(Mandatory = $false, ParameterSetName = 'InputObject_OfferDelegations_CreateOrUpdate')]
        [string]
        $SubscriptionId,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'OfferDelegations_CreateOrUpdate')]
        [Alias('OfferDelegationName')]
        [string]
        $Name,
    
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'ResourceId_OfferDelegations_CreateOrUpdate')]
        [System.String]
        $ResourceId,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'OfferDelegations_CreateOrUpdate')]
        [Parameter(Mandatory = $true, ParameterSetName = 'ResourceId_OfferDelegations_CreateOrUpdate')]
        [Parameter(Mandatory = $true, ParameterSetName = 'InputObject_OfferDelegations_CreateOrUpdate')]
        [System.String]
        $ResourceGroup,
    
        [Parameter(Mandatory = $false, ParameterSetName = 'OfferDelegations_CreateOrUpdate')]
        [Parameter(Mandatory = $false, ParameterSetName = 'ResourceId_OfferDelegations_CreateOrUpdate')]
        [Parameter(Mandatory = $false, ParameterSetName = 'InputObject_OfferDelegations_CreateOrUpdate')]
        [string]
        $Location,
    
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'InputObject_OfferDelegations_CreateOrUpdate')]
        [Microsoft.AzureStack.Management.Subscriptions.Admin.Models.OfferDelegation]
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

        
    $flattenedParameters = @('Id', 'Type', 'Tags', 'SubscriptionId', 'Location')
    $utilityCmdParams = @{}
    $flattenedParameters | ForEach-Object {
        if($PSBoundParameters.ContainsKey($_)) {
            $utilityCmdParams[$_] = $PSBoundParameters[$_]
        }
    }
    $NewOfferDelegation = New-OfferDelegationObject @utilityCmdParams

 
    $OfferDelegationName = $Name

 
    if('InputObject_OfferDelegations_CreateOrUpdate' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_OfferDelegations_CreateOrUpdate' -eq $PsCmdlet.ParameterSetName) {
        $GetArmResourceIdParameterValue_params = @{
            IdTemplate = '/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.Subscriptions.Admin/offers/{offer}/offerDelegations/{offerDelegationName}'
        }

        if('ResourceId_OfferDelegations_CreateOrUpdate' -eq $PsCmdlet.ParameterSetName) {
            $GetArmResourceIdParameterValue_params['Id'] = $ResourceId
        }
        else {
            $GetArmResourceIdParameterValue_params['Id'] = $InputObject.Id
        }
        $ArmResourceIdParameterValues = Get-ArmResourceIdParameterValue @GetArmResourceIdParameterValue_params
        $resourceGroupName = $ArmResourceIdParameterValues['resourceGroupName']

        $offer = $ArmResourceIdParameterValues['offer']

        $offerDelegationName = $ArmResourceIdParameterValues['offerDelegationName']
    }


    if ('OfferDelegations_CreateOrUpdate' -eq $PsCmdlet.ParameterSetName -or 'InputObject_OfferDelegations_CreateOrUpdate' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_OfferDelegations_CreateOrUpdate' -eq $PsCmdlet.ParameterSetName) {
        Write-Verbose -Message 'Performing operation CreateOrUpdateWithHttpMessagesAsync on $SubscriptionsAdminClient.'
        $TaskResult = $SubscriptionsAdminClient.OfferDelegations.CreateOrUpdateWithHttpMessagesAsync($ResourceGroup, $Offer)
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

