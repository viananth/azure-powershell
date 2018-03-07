<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    Removes the specified tenant subscription.

.DESCRIPTION
    Removes the specified tenant subscription.

.PARAMETER Subscription
    Subscription parameter.

.EXAMPLE
    Remove-AzsUserSubscription -SubscriptionId "c90173b1-de7a-4b1d-8600-b832b0e65946"
#>
function Remove-AzsUserSubscription
{
    [CmdletBinding(DefaultParameterSetName='Subscriptions_Delete')]
    param(    
        [Parameter(Mandatory = $true, ParameterSetName = 'Subscriptions_Delete', Position=0)]
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
        FullClientTypeName = 'Microsoft.AzureStack.Management.Subscriptions.Admin.SubscriptionsAdminClient'
    }

    $GlobalParameterHashtable = @{}
    $NewServiceClient_params['GlobalParameterHashtable'] = $GlobalParameterHashtable
     
    #$GlobalParameterHashtable['SubscriptionId'] = $null
    #if($PSBoundParameters.ContainsKey('SubscriptionId')) {
    #    $GlobalParameterHashtable['SubscriptionId'] = $PSBoundParameters['SubscriptionId']
    #}

    $SubscriptionsAdminClient = New-ServiceClient @NewServiceClient_params


    if ('Subscriptions_Delete' -eq $PsCmdlet.ParameterSetName) {
        Write-Verbose -Message 'Performing operation DeleteWithHttpMessagesAsync on $SubscriptionsAdminClient.'
        $TaskResult = $SubscriptionsAdminClient.Subscriptions.DeleteWithHttpMessagesAsync($SubscriptionId)
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

