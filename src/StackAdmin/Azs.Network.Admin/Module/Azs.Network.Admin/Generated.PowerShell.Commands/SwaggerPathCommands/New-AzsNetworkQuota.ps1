<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    Create or update a quota.

.DESCRIPTION
    Create or update a quota.

.PARAMETER Name
    Name of the resource.

.PARAMETER Location
    Location of the resource.

.PARAMETER MaxNicsPerSubscription
    The maximum NICs allowed per subscription.

.PARAMETER MaxPublicIpsPerSubscription
    The maximum public IP addresses allowed per subscription.

.PARAMETER MaxVirtualNetworkGatewayConnectionsPerSubscription
    The maximum number of virtual network gateway connections allowed per subscription.

.PARAMETER MaxVnetsPerSubscription
    The maxium number of virtual networks allowed per subscription.

.PARAMETER MaxVirtualNetworkGatewaysPerSubscription
    The maximum number of virtual network gateways allowed per subscription.

.PARAMETER MaxSecurityGroupsPerSubscription
    The maximum number of security groups allowed per subscription.

.PARAMETER MaxLoadBalancersPerSubscription
    The maximum number of load balancers allowed per subscription.

.EXAMPLE

    PS C:\> New-AzsNetworkQuota -Name NetworkQuota1 -MaxNicsPerSubscription 150 -MaxPublicIpsPerSubscription 150


    MaxPublicIpsPerSubscription                        : 150
    MaxVnetsPerSubscription                            : 150
    MaxVirtualNetworkGatewaysPerSubscription           : 1
    MaxVirtualNetworkGatewayConnectionsPerSubscription : 2
    MaxLoadBalancersPerSubscription                    : 50
    MaxNicsPerSubscription                             : 50
    MaxSecurityGroupsPerSubscription                   : 50
    MigrationPhase                                     : None
    Id                                                 : /subscriptions/df5abebb-3edc-40c5-9155-b4ab239d79d3/providers/Microsoft.Network.Admin/locations/local/quotas/Networ
                                                         kQuota1
    Name                                               : NetworkQuota1
    Type                                               : Microsoft.Network.Admin/quotas
    Location                                           : 
    Tags                                               : 

#>
function New-AzsNetworkQuota {
    [OutputType([Microsoft.AzureStack.Management.Network.Admin.Models.Quota])]
    [CmdletBinding(DefaultParameterSetName = 'Quotas_CreateOrUpdate')]
    param(
        [Parameter(Mandatory = $true, ParameterSetName = 'Quotas_CreateOrUpdate')]
        [System.String]
        $Name,

        [Parameter(Mandatory = $false)]
        [long]
        $MaxNicsPerSubscription = 100,

        [Parameter(Mandatory = $false)]
        [long]
        $MaxPublicIpsPerSubscription = 50,

        [Parameter(Mandatory = $false)]
        [long]
        $MaxVirtualNetworkGatewayConnectionsPerSubscription = 2,

        [Parameter(Mandatory = $false)]
        [long]
        $MaxVnetsPerSubscription = 50,

        [Parameter(Mandatory = $false)]
        [long]
        $MaxVirtualNetworkGatewaysPerSubscription = 1,

        [Parameter(Mandatory = $false)]
        [long]
        $MaxSecurityGroupsPerSubscription = 50,

        [Parameter(Mandatory = $false)]
        [long]
        $MaxLoadBalancersPerSubscription = 50,

        [Parameter(Mandatory = $false, ParameterSetName = 'Quotas_CreateOrUpdate')]
        [System.String]
        $Location,

        [Parameter(Mandatory = $false, DontShow = $true)]
        [ValidateSet('None', 'Prepare', 'Commit', 'Abort')]
        [string]
        $MigrationPhase = 'Prepare'
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
            FullClientTypeName = 'Microsoft.AzureStack.Management.Network.Admin.NetworkAdminClient'
        }

        $GlobalParameterHashtable = @{}
        $NewServiceClient_params['GlobalParameterHashtable'] = $GlobalParameterHashtable

        $GlobalParameterHashtable['SubscriptionId'] = $null
        if ($PSBoundParameters.ContainsKey('SubscriptionId')) {
            $GlobalParameterHashtable['SubscriptionId'] = $PSBoundParameters['SubscriptionId']
        }

        $NetworkAdminClient = New-ServiceClient @NewServiceClient_params

        if (-not $PSBoundParameters.ContainsKey('Location')) {
            $Location = (Get-AzureRMLocation).Location
        }

        # Create object
        $flattenedParameters = @(
            'MaxNicsPerSubscription', 'MaxPublicIpsPerSubscription',
            'MaxVirtualNetworkGatewayConnectionsPerSubscription', 'MaxVnetsPerSubscription',
            'MaxVirtualNetworkGatewaysPerSubscription', 'MaxSecurityGroupsPerSubscription',
            'MaxLoadBalancersPerSubscription', 'MigrationPhase'
        )
        $utilityCmdParams = @{}
        $flattenedParameters | ForEach-Object {
            $utilityCmdParams[$_] = Get-Variable -Name $_ -ValueOnly
        }
        $Quota = New-QuotaObject @utilityCmdParams

        if ('Quotas_CreateOrUpdate' -eq $PsCmdlet.ParameterSetName) {
            Write-Verbose -Message 'Performing operation CreateOrUpdateWithHttpMessagesAsync on $NetworkAdminClient.'
            $TaskResult = $NetworkAdminClient.Quotas.CreateOrUpdateWithHttpMessagesAsync($Location, $Name, $Quota)
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

