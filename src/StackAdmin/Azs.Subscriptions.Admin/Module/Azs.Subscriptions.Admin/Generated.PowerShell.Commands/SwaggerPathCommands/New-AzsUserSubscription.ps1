<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    

.DESCRIPTION
    Get the list of subscriptions.

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
    Location where resource is location.

.PARAMETER OfferId
    Identifier of the offer under the scope of a delegated provider.

.PARAMETER Subscription
    Subscription parameter.

#>
function New-AzsUserSubscription
{
    [OutputType([Microsoft.AzureStack.Management.Subscriptions.Admin.Models.Subscription])]
    [CmdletBinding(DefaultParameterSetName='Subscriptions_CreateOrUpdate')]
    param(    
        [Parameter(Mandatory = $false, ParameterSetName = 'Subscriptions_CreateOrUpdate')]
        [string]
        $TenantId,
    
        [Parameter(Mandatory = $false, ParameterSetName = 'Subscriptions_CreateOrUpdate')]
        [string]
        $DisplayName,
    
        [Parameter(Mandatory = $false, ParameterSetName = 'Subscriptions_CreateOrUpdate')]
        [string]
        $DelegatedProviderSubscriptionId,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'Subscriptions_CreateOrUpdate')]
        [string]
        $Owner,
    
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
    
        [Parameter(Mandatory = $true, ParameterSetName = 'Subscriptions_CreateOrUpdate')]
        [string]
        $OfferId,
    
        [Parameter(Mandatory = $false, ParameterSetName = 'Subscriptions_CreateOrUpdate')]
        [Alias("SubscriptionId")]
        [System.String]
        $NewSubscriptionId
    )

    Begin 
    {
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
    if($PSBoundParameters.ContainsKey('SubscriptionId')) {
        $GlobalParameterHashtable['SubscriptionId'] = $PSBoundParameters['SubscriptionId']
    }

    $SubscriptionsAdminClient = New-ServiceClient @NewServiceClient_params

    if (-not $PSBoundParameters.ContainsKey('RoutingResourceManagerType'))
    {
         $RoutingResourceManagerType = "Default"
         $PSBoundParameters.Add("RoutingResourceManagerType", $RoutingResourceManagerType)
    }

    if (-not $PSBoundParameters.ContainsKey('State'))
    {
         $State = "Enabled"
         $PSBoundParameters.Add("State", $State)
    }
    
    if (-not ($PSBoundParameters.ContainsKey('NewSubscriptionId') -or $PSBoundParameters.ContainsKey('SubscriptionId')))
    {
         $NewSubscriptionId = [Guid]::NewGuid().ToString()
         $PSBoundParameters.Add("NewSubscriptionId", $NewSubscriptionId)
    }
        
    $flattenedParameters = @('TenantId', 'NewSubscriptionId', 'DisplayName', 'DelegatedProviderSubscriptionId', 'Owner', 'RoutingResourceManagerType', 'ExternalReferenceId', 'State', 'OfferId')
    $utilityCmdParams = @{}
    $flattenedParameters | ForEach-Object {
        if($PSBoundParameters.ContainsKey($_)) {
            $utilityCmdParams[$_] = $PSBoundParameters[$_]
        }
    }
    $NewSubscription = New-SubscriptionObject @utilityCmdParams

    if ('Subscriptions_CreateOrUpdate' -eq $PsCmdlet.ParameterSetName) {
        Write-Verbose -Message 'Performing operation CreateOrUpdateWithHttpMessagesAsync on $SubscriptionsAdminClient.'
        $TaskResult = $SubscriptionsAdminClient.Subscriptions.CreateOrUpdateWithHttpMessagesAsync($NewSubscriptionId, $NewSubscription)
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
