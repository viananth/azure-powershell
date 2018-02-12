<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    Offer delegation.

.DESCRIPTION
    Offer delegation.

.PARAMETER ResourceTags
    Resource tags.

.PARAMETER Type
    Type of resource.

.PARAMETER SubscriptionId
    Identifier of the subscription receiving the delegated offer.

.PARAMETER Name
    Name of the resource.

.PARAMETER DelegatedProviderOfferName
    Name of the base DelegatedProvider offer (when the DelegatedProvider is not the admin subscription).

.PARAMETER DelegatedProviderOfferResourceGroupName
    Resource group name of the base DelegatedProvider offer (when the DelegatedProvider is not the admin subscription).

.PARAMETER OfferResourceGroupName
    Resource group name of the base admin offer.

.PARAMETER OfferName
    Name of the base admin offer.

.PARAMETER DelegatedProviderOfferDisplayName
    Display name of the base DelegatedProvider offer (when the DelegatedProvider is not the admin subscription).

.PARAMETER Tags
    List of key-value pairs.

.PARAMETER OfferDescription
    Description of the base admin offer.

.PARAMETER DelegatedProviderOfferDescription
    Description of the base DelegatedProvider offer (when the DelegatedProvider is not the admin subscription).

.PARAMETER DelegatedProviderSubscriptionId
    Identifier of the DelegatedProvider subscription that delegated the offer.

.PARAMETER Id
    URI of the resource.

.PARAMETER Location
    Location where resource is location.

.PARAMETER OfferDisplayName
    Display name of the base admin offer.

#>
function New-DelegatedOfferObject
{
    param(    
        [Parameter(Mandatory = $false)]
        [System.Collections.Generic.Dictionary[[string],[string]]]
        $ResourceTags,
    
        [Parameter(Mandatory = $false)]
        [string]
        $Type,
    
        [Parameter(Mandatory = $false)]
        [string]
        $SubscriptionId,
    
        [Parameter(Mandatory = $false)]
        [string]
        $Name,
    
        [Parameter(Mandatory = $false)]
        [string]
        $DelegatedProviderOfferName,
    
        [Parameter(Mandatory = $false)]
        [string]
        $DelegatedProviderOfferResourceGroupName,
    
        [Parameter(Mandatory = $false)]
        [string]
        $OfferResourceGroupName,
    
        [Parameter(Mandatory = $false)]
        [string]
        $OfferName,
    
        [Parameter(Mandatory = $false)]
        [string]
        $DelegatedProviderOfferDisplayName,
    
        [Parameter(Mandatory = $false)]
        [System.Collections.Generic.Dictionary[[string],[string]]]
        $Tags,
    
        [Parameter(Mandatory = $false)]
        [string]
        $OfferDescription,
    
        [Parameter(Mandatory = $false)]
        [string]
        $DelegatedProviderOfferDescription,
    
        [Parameter(Mandatory = $false)]
        [string]
        $DelegatedProviderSubscriptionId,
    
        [Parameter(Mandatory = $false)]
        [string]
        $Id,
    
        [Parameter(Mandatory = $false)]
        [string]
        $Location,
    
        [Parameter(Mandatory = $false)]
        [string]
        $OfferDisplayName
    )
    
    $Object = New-Object -TypeName Microsoft.AzureStack.Management.Subscriptions.Admin.Models.DelegatedOffer

    $PSBoundParameters.GetEnumerator() | ForEach-Object { 
        if(Get-Member -InputObject $Object -Name $_.Key -MemberType Property)
        {
            $Object.$($_.Key) = $_.Value
        }
    }

    if(Get-Member -InputObject $Object -Name Validate -MemberType Method)
    {
        $Object.Validate()
    }

    return $Object
}

