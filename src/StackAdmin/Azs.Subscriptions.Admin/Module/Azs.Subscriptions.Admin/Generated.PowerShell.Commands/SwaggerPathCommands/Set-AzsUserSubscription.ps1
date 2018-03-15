<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    Updates the specified user subscription

.DESCRIPTION
    Updates the specified user subscription

.PARAMETER TenantId
    Directory tenant identifier.

.PARAMETER SubscriptionId
    Subscription identifier.

.PARAMETER DisplayName
    Subscription name.

.PARAMETER DelegatedProviderSubscriptionId
    Parent DelegatedProvider subscription identifier.

.PARAMETER Owner
    Subscription owner.

.PARAMETER RoutingResourceManagerType
    Routing resource manager type.

.PARAMETER ExternalReferenceId
    External reference identifier.

.PARAMETER State
    Subscription state.

.PARAMETER Location
    Location of the resource.

.PARAMETER OfferId
    Identifier of the offer under the scope of a delegated provider.

.PARAMETER Subscription
    Subscription parameter.

#>
function Set-AzsUserSubscription {
    [OutputType([Microsoft.AzureStack.Management.Subscriptions.Admin.Models.Subscription])]
    [CmdletBinding(DefaultParameterSetName = 'Subscriptions_CreateOrUpdate')]
    param(
        [Parameter(Mandatory = $true, ParameterSetName = 'Subscriptions_CreateOrUpdate')]
        [ValidateScript( {
                [System.Guid]::TryParse($SubscriptionId)
            })]
        [System.Guid]
        $SubscriptionId,

        [Parameter(Mandatory = $false, ParameterSetName = 'Subscriptions_CreateOrUpdate')]
        [string]
        $DisplayName,

        [Parameter(Mandatory = $false, ParameterSetName = 'Subscriptions_CreateOrUpdate')]
        [string]
        $DelegatedProviderSubscriptionId,

        [Parameter(Mandatory = $false, ParameterSetName = 'Subscriptions_CreateOrUpdate')]
        [string]
        $Owner,

        [Parameter(Mandatory = $false, ParameterSetName = 'Subscriptions_CreateOrUpdate')]
        [string]
        $TenantId,

        [Parameter(Mandatory = $false, ParameterSetName = 'Subscriptions_CreateOrUpdate')]
        [ValidateSet('Default', 'Admin')]
        [string]
        $RoutingResourceManagerType,

        [Parameter(Mandatory = $false, ParameterSetName = 'Subscriptions_CreateOrUpdate')]
        [string]
        $ExternalReferenceId,

        [Parameter(Mandatory = $false, ParameterSetName = 'Subscriptions_CreateOrUpdate')]
        [ValidateSet('NotDefined', 'Enabled', 'Warned', 'PastDue', 'Disabled', 'Deleted')]
        [string]
        $State,

        [Parameter(Mandatory = $false, ParameterSetName = 'Subscriptions_CreateOrUpdate')]
        [string]
        $Location,

        [Parameter(Mandatory = $false, ParameterSetName = 'Subscriptions_CreateOrUpdate')]
        [string]
        $OfferId
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
        $SubscriptionsAdminClient = New-ServiceClient @NewServiceClient_params

        $flattenedParameters = @('TenantId', 'SubscriptionId', 'DisplayName', 'DelegatedProviderSubscriptionId', 'Owner', 'RoutingResourceManagerType', 'ExternalReferenceId', 'State', 'Location', 'OfferId')
        $utilityCmdParams = @{}
        $flattenedParameters | ForEach-Object {
            if ($PSBoundParameters.ContainsKey($_)) {
                $utilityCmdParams[$_] = $PSBoundParameters[$_]
            }
        }
        $NewSubscription = New-SubscriptionObject @utilityCmdParams

        if (-not $PSBoundParameters.ContainsKey('Location')) {
            $Location = (Get-AzureRMLocation).Location
        }

        if ('Subscriptions_CreateOrUpdate' -eq $PsCmdlet.ParameterSetName) {
            Write-Verbose -Message 'Performing operation CreateOrUpdateWithHttpMessagesAsync on $SubscriptionsAdminClient.'
            $TaskResult = $SubscriptionsAdminClient.Subscriptions.CreateOrUpdateWithHttpMessagesAsync($SubscriptionId, $NewSubscription)
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

