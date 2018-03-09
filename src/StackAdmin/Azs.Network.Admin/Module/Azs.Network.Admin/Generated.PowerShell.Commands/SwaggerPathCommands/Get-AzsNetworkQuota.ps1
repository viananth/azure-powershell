<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    List all quotas.

.DESCRIPTION
    List all quotas. Limit the list by passing a name or filter.

.PARAMETER Name
    Name of the resource.

.PARAMETER Location
    Location of the resource.

.PARAMETER Filter
    OData filter parameter.

.PARAMETER ResourceId
    The resource id.

.PARAMETER InputObject
    The input object of type Microsoft.AzureStack.Management.Network.Admin.Models.Quota.

.EXAMPLE

    PS C:\> Get-AzsNetworkQuota -Name NetworkQuota1


    MaxPublicIpsPerSubscription                        : 50
    MaxVnetsPerSubscription                            : 50
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
function Get-AzsNetworkQuota {
    [OutputType([Microsoft.AzureStack.Management.Network.Admin.Models.Quota])]
    [CmdletBinding(DefaultParameterSetName = 'Quotas_List')]
    param(
        [Parameter(Mandatory = $true, ParameterSetName = 'Quotas_Get')]
        [System.String]
        $Name,

        [Parameter(Mandatory = $false, ParameterSetName = 'Quotas_Get')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Quotas_List')]
        [System.String]
        $Location,

        [Parameter(Mandatory = $false, ParameterSetName = 'Quotas_List')]
        [string]
        $Filter,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'ResourceId_Quotas_Get')]
        [System.String]
        $ResourceId,

        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'InputObject_Quotas_Get')]
        [Microsoft.AzureStack.Management.Network.Admin.Models.Quota]
        $InputObject
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

        $oDataQuery = ""
        if ($Filter) {
            $oDataQuery += "&`$Filter=$Filter"
        }
        $oDataQuery = $oDataQuery.Trim("&")

        if ('InputObject_Quotas_Get' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_Quotas_Get' -eq $PsCmdlet.ParameterSetName) {
            $GetArmResourceIdParameterValue_params = @{
                IdTemplate = '/subscriptions/{subscriptionId}/providers/Microsoft.Network.Admin/locations/{location}/quotas/{resourceName}'
            }

            if ('ResourceId_Quotas_Get' -eq $PsCmdlet.ParameterSetName) {
                $GetArmResourceIdParameterValue_params['Id'] = $ResourceId
            } else {
                $GetArmResourceIdParameterValue_params['Id'] = $InputObject.Id
            }
            $ArmResourceIdParameterValues = Get-ArmResourceIdParameterValue @GetArmResourceIdParameterValue_params
            $location = $ArmResourceIdParameterValues['location']

            $Name = $ArmResourceIdParameterValues['resourceName']
        } elseif (-not $PSBoundParameters.ContainsKey('Location')) {
            $Location = (Get-AzureRMLocation).Location
        }


        if ('Quotas_List' -eq $PsCmdlet.ParameterSetName) {
            Write-Verbose -Message 'Performing operation ListWithHttpMessagesAsync on $NetworkAdminClient.'
            $TaskResult = $NetworkAdminClient.Quotas.ListWithHttpMessagesAsync($Location, $(if ($oDataQuery) {
                        New-Object -TypeName "Microsoft.Rest.Azure.OData.ODataQuery``1[Microsoft.AzureStack.Management.Network.Admin.Models.Quota]" -ArgumentList $oDataQuery
                    } else {
                        $null
                    }))
        } elseif ('Quotas_Get' -eq $PsCmdlet.ParameterSetName -or 'InputObject_Quotas_Get' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_Quotas_Get' -eq $PsCmdlet.ParameterSetName) {
            Write-Verbose -Message 'Performing operation GetWithHttpMessagesAsync on $NetworkAdminClient.'
            $TaskResult = $NetworkAdminClient.Quotas.GetWithHttpMessagesAsync($Location, $Name)
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

