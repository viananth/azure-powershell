<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    Represents an offering of services against which a subscription can be created.

.DESCRIPTION
    Represents an offering of services against which a subscription can be created.

.PARAMETER Tags
    List of key-value pairs.

.PARAMETER Type
    Type of resource.

.PARAMETER MaxSubscriptionsPerAccount
    Maximum subscriptions per account.

.PARAMETER DisplayName
    Display name of offer.

.PARAMETER BasePlanIds
    Identifiers of the base plans that become available to the tenant immediately when a tenant subscribes to the offer.

.PARAMETER Name
    Name of the resource.

.PARAMETER Description
    Description of offer.

.PARAMETER ExternalReferenceId
    External reference identifier.

.PARAMETER State
    Offer accessibility state.

.PARAMETER Id
    URI of the resource.

.PARAMETER Location
    Location where resource is location.

.PARAMETER SubscriptionCount
    Current subscription count.

.PARAMETER AddonPlanDefinition
    References to add-on plans that a tenant can optionally acquire as a part of the offer.

#>
function New-OfferObject
{
    param(    
        [Parameter(Mandatory = $false)]
        [System.Collections.Generic.Dictionary[[string],[string]]]
        $Tags,
    
        [Parameter(Mandatory = $false)]
        [string]
        $Type,
    
        [Parameter(Mandatory = $false)]
        [int64]
        $MaxSubscriptionsPerAccount,
    
        [Parameter(Mandatory = $false)]
        [string]
        $DisplayName,
    
        [Parameter(Mandatory = $false)]
        [string[]]
        $BasePlanIds,
    
        [Parameter(Mandatory = $false)]
        [string]
        $Name,
    
        [Parameter(Mandatory = $false)]
        [string]
        $Description,
    
        [Parameter(Mandatory = $false)]
        [string]
        $ExternalReferenceId,
    
        [Parameter(Mandatory = $false)]
        [ValidateSet('Private', 'Public', 'Decommissioned')]
        [string]
        $State,
    
        [Parameter(Mandatory = $false)]
        [string]
        $Id,
    
        [Parameter(Mandatory = $false)]
        [string]
        $Location,
    
        [Parameter(Mandatory = $false)]
        [int64]
        $SubscriptionCount,
    
        [Parameter(Mandatory = $false)]
        [Microsoft.AzureStack.Management.Subscriptions.Admin.Models.AddonPlanDefinition[]]
        $AddonPlanDefinition
    )
    
    $Object = New-Object -TypeName Microsoft.AzureStack.Management.Subscriptions.Admin.Models.Offer

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

