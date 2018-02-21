<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    

.DESCRIPTION
    Get the list of subscriptions.

.PARAMETER SubscriptionId
    Id of the subscription.

#>
function Get-AzsSubscription
{
    [OutputType([Microsoft.AzureStack.Management.Subscriptions.Models.Subscription])]
    [CmdletBinding(DefaultParameterSetName='Subscriptions_List')]
    param(    
        [Parameter(Mandatory = $true, ParameterSetName = 'Subscriptions_Get')]
        [System.String]
        $SubscriptionId
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
        FullClientTypeName = 'Microsoft.AzureStack.Management.Subscriptions.SubscriptionsManagementClient'
    }

    $GlobalParameterHashtable = @{}
    $NewServiceClient_params['GlobalParameterHashtable'] = $GlobalParameterHashtable

    $SubscriptionsManagementClient = New-ServiceClient @NewServiceClient_params


    if ('Subscriptions_List' -eq $PsCmdlet.ParameterSetName) {
        Write-Verbose -Message 'Performing operation ListWithHttpMessagesAsync on $SubscriptionsManagementClient.'
        $TaskResult = $SubscriptionsManagementClient.Subscriptions.ListWithHttpMessagesAsync()
    } elseif ('Subscriptions_Get' -eq $PsCmdlet.ParameterSetName) {
        Write-Verbose -Message 'Performing operation GetWithHttpMessagesAsync on $SubscriptionsManagementClient.'
        $TaskResult = $SubscriptionsManagementClient.Subscriptions.GetWithHttpMessagesAsync($SubscriptionId)
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

