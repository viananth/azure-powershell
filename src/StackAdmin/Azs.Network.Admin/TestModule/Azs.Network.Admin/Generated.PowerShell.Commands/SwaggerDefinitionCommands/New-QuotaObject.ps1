<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    Network quota resource.

.DESCRIPTION
    Network quota resource.

.PARAMETER Tags
    List of key value pairs.

.PARAMETER Type
    Type of resource.

.PARAMETER MigrationPhase
    State of migration such as None, Prepare, Commit and Abort.

.PARAMETER MaxNicsPerSubscription
    Maximum number of NICs a tenant subscription can provision.

.PARAMETER MaxPublicIpsPerSubscription
    Maximum number of Public IP Addresses a tenant subscription can provision.

.PARAMETER MaxVirtualNetworkGatewayConnectionsPerSubscription
    Maximum number of Virtual Network Gateway Connections a tenant subscription can provision.

.PARAMETER Name
    Name of the resource.

.PARAMETER Id
    URI of the resource.

.PARAMETER MaxVnetsPerSubscription
    Maximum number of Virtual Networks a tenant subscription can provision.

.PARAMETER MaxVirtualNetworkGatewaysPerSubscription
    Maximum number of Virtual Network Gateways a tenant subscription can provision.

.PARAMETER MaxSecurityGroupsPerSubscription
    Maximum number of Security Groups a tenant subscription can provision.

.PARAMETER Location
    Region Location of resource.

.PARAMETER MaxLoadBalancersPerSubscription
    Maximum number of Load Balancers a tenant subscription can provision.

#>
function New-QuotaObject
{
    param(    
        [Parameter(Mandatory = $false)]
        [System.Collections.Generic.Dictionary[[string],[string]]]
        $Tags,
    
        [Parameter(Mandatory = $false)]
        [string]
        $Type,
    
        [Parameter(Mandatory = $false)]
        [ValidateSet('None', 'Prepare', 'Commit', 'Abort')]
        [string]
        $MigrationPhase,
    
        [Parameter(Mandatory = $false)]
        [int64]
        $MaxNicsPerSubscription,
    
        [Parameter(Mandatory = $false)]
        [int64]
        $MaxPublicIpsPerSubscription,
    
        [Parameter(Mandatory = $false)]
        [int64]
        $MaxVirtualNetworkGatewayConnectionsPerSubscription,
    
        [Parameter(Mandatory = $false)]
        [string]
        $Name,
    
        [Parameter(Mandatory = $false)]
        [string]
        $Id,
    
        [Parameter(Mandatory = $false)]
        [int64]
        $MaxVnetsPerSubscription,
    
        [Parameter(Mandatory = $false)]
        [int64]
        $MaxVirtualNetworkGatewaysPerSubscription,
    
        [Parameter(Mandatory = $false)]
        [int64]
        $MaxSecurityGroupsPerSubscription,
    
        [Parameter(Mandatory = $false)]
        [string]
        $Location,
    
        [Parameter(Mandatory = $false)]
        [int64]
        $MaxLoadBalancersPerSubscription
    )
    
    $Object = New-Object -TypeName Microsoft.AzureStack.Management.Network.Admin.Models.Quota

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

