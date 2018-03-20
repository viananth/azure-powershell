<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    Get an overview of the state of the network resource provider.

.DESCRIPTION
    Get an overview of the state of the network resource provider.  Individual properties provide detailed counts of resource usage and health by component.

.EXAMPLE

	PS C:\> Get-AzsResourceProviderState


	ProvisioningState     : Succeeded
	VirtualNetworkHealth  : Microsoft.AzureStack.Management.Network.Admin.Models.AdminOverviewResourceHealth
	LoadBalancerMuxHealth : Microsoft.AzureStack.Management.Network.Admin.Models.AdminOverviewResourceHealth
	VirtualGatewayHealth  : Microsoft.AzureStack.Management.Network.Admin.Models.AdminOverviewResourceHealth
	PublicIpAddressUsage  : Microsoft.AzureStack.Management.Network.Admin.Models.AdminOverviewResourceUsage
	BackendIpUsage        : Microsoft.AzureStack.Management.Network.Admin.Models.AdminOverviewResourceUsage
	MacAddressUsage       : Microsoft.AzureStack.Management.Network.Admin.Models.AdminOverviewResourceUsage
	Id                    : /subscriptions/df5abebb-3edc-40c5-9155-b4ab239d79d3/providers/Microsoft.Network.Admin/adminOverview/
	Name                  :
	Type                  : Microsoft.Network.Admin/adminOverview
	Location              :
	Tags                  :

.EXAMPLE

	PS C:\> (Get-AzsNetworkAdminOverview).PublicIpAddressUsage

	TotalResourceCount InUseResourceCount
	------------------ ------------------
				   255                 31

#>
function Get-AzsNetworkAdminOverview {
    [OutputType([Microsoft.AzureStack.Management.Network.Admin.Models.AdminOverview])]
    [CmdletBinding(DefaultParameterSetName = 'ResourceProviderState_Get')]
    param(
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

        if ('ResourceProviderState_Get' -eq $PsCmdlet.ParameterSetName) {
            Write-Verbose -Message 'Performing operation GetWithHttpMessagesAsync on $NetworkAdminClient.'
            $TaskResult = $NetworkAdminClient.ResourceProviderState.GetWithHttpMessagesAsync()
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

