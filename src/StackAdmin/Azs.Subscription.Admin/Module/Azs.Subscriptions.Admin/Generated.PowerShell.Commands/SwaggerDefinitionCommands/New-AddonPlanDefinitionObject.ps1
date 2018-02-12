<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    Contains the name of the desired plan to be linked or unlinked from an offer.

.DESCRIPTION
    Contains the name of the desired plan to be linked or unlinked from an offer.

.PARAMETER PlanId
    Plan identifier.

.PARAMETER MaxAcquisitionCount
    Maximum number of instances that can be acquired by a single subscription. If not specified, the assumed value is 1.

#>
function New-AddonPlanDefinitionObject
{
    param(    
        [Parameter(Mandatory = $false)]
        [string]
        $PlanId,
    
        [Parameter(Mandatory = $false)]
        [int64]
        $MaxAcquisitionCount
    )
    
    $Object = New-Object -TypeName Microsoft.AzureStack.Management.Subscriptions.Admin.Models.AddonPlanDefinition

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

