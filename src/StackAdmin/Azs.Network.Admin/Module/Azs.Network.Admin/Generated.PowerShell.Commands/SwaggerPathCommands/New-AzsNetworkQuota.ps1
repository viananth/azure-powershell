<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    Create or update a quota.

.DESCRIPTION
    Create or update a quota.

.PARAMETER ResourceId
    The resource id.

.PARAMETER Quota
    New network quota to create.

.PARAMETER Name
    Name of the resource.

.PARAMETER Location
    Location of the resource.

.PARAMETER InputObject
    The input object of type Microsoft.AzureStack.Management.Network.Admin.Models.Quota.

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

        [Parameter(Mandatory = $false)]
        [ValidateSet('None', 'Prepare', 'Commit', 'Abort')]
        [string]
        $MigrationPhase = 'Prepare',

        [Parameter(Mandatory = $false, ParameterSetName = 'Quotas_CreateOrUpdate')]
        [System.String]
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
            'MaxLoadBalancersPerSubscription'
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

