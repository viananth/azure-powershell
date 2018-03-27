<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    Create a directory tenant.

.DESCRIPTION
    Create a directory tenant.

.PARAMETER Id
    URI of the resource.

.PARAMETER Type
    Type of resource.

.PARAMETER Tags
    List of key-value pairs.

.PARAMETER TenantId
    Tenant unique identifier.

.PARAMETER ResourceGroup
    The resource group the resource is located under.

.PARAMETER Location
    Location of the resource.

.PARAMETER Name
    Directory tenant name.

#>
function New-AzsDirectoryTenant {
    [OutputType([Microsoft.AzureStack.Management.Subscriptions.Admin.Models.DirectoryTenant])]
    [CmdletBinding(DefaultParameterSetName = 'Create')]
    param(
        [Parameter(Mandatory = $false, ParameterSetName = 'Create')]
        [string]
        $Id,

        [Parameter(Mandatory = $false, ParameterSetName = 'Create')]
        [string]
        $Type,

        [Parameter(Mandatory = $false, ParameterSetName = 'Create')]
        [System.Collections.Generic.Dictionary[[string], [string]]]
        $Tags,

        [Parameter(Mandatory = $false, ParameterSetName = 'Create')]
        [string]
        $TenantId,

        [Parameter(Mandatory = $true, ParameterSetName = 'Create')]
        [System.String]
        $ResourceGroupName,

        [Parameter(Mandatory = $false, ParameterSetName = 'Create')]
        [string]
        $Location,

        [Parameter(Mandatory = $true, ParameterSetName = 'Create')]
        [System.String]
        $Name
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
            FullClientTypeName = 'Microsoft.AzureStack.Management.Subscriptions.Admin.SubscriptionsAdminClient'
        }

        $GlobalParameterHashtable = @{}
        $NewServiceClient_params['GlobalParameterHashtable'] = $GlobalParameterHashtable

        $GlobalParameterHashtable['SubscriptionId'] = $null
        if ($PSBoundParameters.ContainsKey('SubscriptionId')) {
            $GlobalParameterHashtable['SubscriptionId'] = $PSBoundParameters['SubscriptionId']
        }

        $SubscriptionsAdminClient = New-ServiceClient @NewServiceClient_params


        $flattenedParameters = @('Id', 'Type', 'Tags', 'TenantId', 'Location')
        $utilityCmdParams = @{}
        $flattenedParameters | ForEach-Object {
            if ($PSBoundParameters.ContainsKey($_)) {
                $utilityCmdParams[$_] = $PSBoundParameters[$_]
            }
        }
        $NewTenant = New-DirectoryTenantObject @utilityCmdParams

        $Tenant = $Name

        if (-not $PSBoundParameters.ContainsKey('Location')) {
            $Location = (Get-AzureRMLocation).Location
        }


        if ('Create' -eq $PsCmdlet.ParameterSetName) {
            Write-Verbose -Message 'Performing operation CreateOrUpdateWithHttpMessagesAsync on $SubscriptionsAdminClient.'
            $TaskResult = $SubscriptionsAdminClient.DirectoryTenants.CreateOrUpdateWithHttpMessagesAsync($ResourceGroupName, $Tenant, $NewTenant)
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

