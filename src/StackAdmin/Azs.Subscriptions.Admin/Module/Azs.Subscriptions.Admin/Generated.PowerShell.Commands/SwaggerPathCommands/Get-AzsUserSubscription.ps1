<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    Get the list of user subscriptions as administrator.    

.DESCRIPTION
    Get the list of user subscriptions as administrator.

.PARAMETER Filter
    OData filter parameter.

.PARAMETER Subscription
    Subscription parameter.

.EXAMPLE

    PS C:\Windows\system32> Get-AzsUserSubscription

    DelegatedProviderSubscriptionId : 0a823c45-d9e7-4812-a138-74e22213693a
    DisplayName                     : cnur5172tenantresellersubscription696
    Id                              : /subscriptions/0a823c45-d9e7-4812-a138-74e22213693a/providers/Microsoft.Subscriptions.Admin/subscriptions/c90173b1-de7a-4b1d-8600-b832b0e65946
    ExternalReferenceId             : 
    OfferId                         : /subscriptions/0a823c45-d9e7-4812-a138-74e22213693a/resourceGroups/cnur5172resellersubscrrg696/providers/Microsoft.Subscriptions.Admin/offers/cnur5172tenant
                                    subsvcoffer696
    Owner                           : tenantadmin1@msazurestack.onmicrosoft.com
    RoutingResourceManagerType      : Default
    State                           : Enabled
    SubscriptionId                  : c90173b1-de7a-4b1d-8600-b832b0e65946
    TenantId                        : d669642b-89ec-466e-af2c-2ceab9fef685

#>
function Get-AzsUserSubscription
{
    [OutputType([Microsoft.AzureStack.Management.Subscriptions.Admin.Models.Subscription])]
    [CmdletBinding(DefaultParameterSetName='Subscriptions_List')]
    param(    
        [Parameter(Mandatory = $true, ParameterSetName = 'Subscriptions_Get')]
        [System.String]
        $Subscription,

        [Parameter(Mandatory = $false, ParameterSetName = 'Subscriptions_List')]
        [string]
        $Filter
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

    $oDataQuery = ""
    if ($Filter) { $oDataQuery += "&`$Filter=$Filter" }
    $oDataQuery = $oDataQuery.Trim("&")


    if ('Subscriptions_List' -eq $PsCmdlet.ParameterSetName) {
        Write-Verbose -Message 'Performing operation ListWithHttpMessagesAsync on $SubscriptionsAdminClient.'
        $TaskResult = $SubscriptionsAdminClient.Subscriptions.ListWithHttpMessagesAsync()
    } elseif ('Subscriptions_Get' -eq $PsCmdlet.ParameterSetName) {
        Write-Verbose -Message 'Performing operation GetWithHttpMessagesAsync on $SubscriptionsAdminClient.'
        $TaskResult = $SubscriptionsAdminClient.Subscriptions.GetWithHttpMessagesAsync($Subscription)
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

