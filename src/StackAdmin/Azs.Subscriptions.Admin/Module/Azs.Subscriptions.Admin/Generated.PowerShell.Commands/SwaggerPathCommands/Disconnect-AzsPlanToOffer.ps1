<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    

.DESCRIPTION
    Unlink a plan from an offer.

.PARAMETER PlanLinkType
    Type of the plan link.

.PARAMETER OfferName
    Name of an offer.

.PARAMETER PlanName
    Name of the plan.

.PARAMETER ResourceGroup
    The resource group the resource is located under.

.PARAMETER MaxAcquisitionCount
    The maximum acquisition count by subscribers

#>
function Disconnect-AzsPlanToOffer
{
    [CmdletBinding(DefaultParameterSetName='Offers_Unlink')]
    param(    
        [Parameter(Mandatory = $false, ParameterSetName = 'Offers_Unlink')]
        [ValidateSet('None', 'Base', 'Addon')]
        [string]
        $PlanLinkType,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'Offers_Unlink')]
        [System.String]
        $OfferName,
    
        [Parameter(Mandatory = $false, ParameterSetName = 'Offers_Unlink')]
        [string]
        $PlanName,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'Offers_Unlink')]
        [System.String]
        $ResourceGroupName,
    
        [Parameter(Mandatory = $false, ParameterSetName = 'Offers_Unlink')]
        [int64]
        $MaxAcquisitionCount
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

        
    $flattenedParameters = @('PlanName', 'PlanLinkType', 'MaxAcquisitionCount')
    $utilityCmdParams = @{}
    $flattenedParameters | ForEach-Object {
        if($PSBoundParameters.ContainsKey($_)) {
            $utilityCmdParams[$_] = $PSBoundParameters[$_]
        }
    }
    $PlanLink = New-PlanLinkDefinitionObject @utilityCmdParams



    if ('Offers_Unlink' -eq $PsCmdlet.ParameterSetName) {
        Write-Verbose -Message 'Performing operation UnlinkWithHttpMessagesAsync on $SubscriptionsAdminClient.'
        $TaskResult = $SubscriptionsAdminClient.Offers.UnlinkWithHttpMessagesAsync($ResourceGroupName, $OfferName, $PlanLink)
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

