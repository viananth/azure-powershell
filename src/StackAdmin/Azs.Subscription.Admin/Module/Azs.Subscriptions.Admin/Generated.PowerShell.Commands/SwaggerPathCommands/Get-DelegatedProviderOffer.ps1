<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    

.DESCRIPTION
    Get the list of delegated provider offers.

.PARAMETER DelegatedProvider
    DelegatedProvider identifier.

.PARAMETER Name
    Name of an offer.

.PARAMETER Skip
    Skip the first N items as specified by the parameter value.

.PARAMETER ResourceId
    The resource id.

.PARAMETER InputObject
    The input object of type Microsoft.AzureStack.Management.Subscriptions.Admin.Models.DelegatedProviderOffer.

.PARAMETER Top
    Return the top N items as specified by the parameter value. Applies after the -Skip parameter.

#>
function Get-DelegatedProviderOffer
{
    [OutputType([Microsoft.AzureStack.Management.Subscriptions.Admin.Models.DelegatedProviderOffer])]
    [CmdletBinding(DefaultParameterSetName='DelegatedProviderOffers_List')]
    param(    
        [Parameter(Mandatory = $true, ParameterSetName = 'DelegatedProviderOffers_List')]
        [Parameter(Mandatory = $true, ParameterSetName = 'DelegatedProviderOffers_Get')]
        [System.String]
        $DelegatedProvider,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'DelegatedProviderOffers_Get')]
        [Alias('Offer')]
        [System.String]
        $Name,
    
        [Parameter(Mandatory = $false, ParameterSetName = 'DelegatedProviderOffers_List')]
        [int]
        $Skip = -1,
    
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'ResourceId_DelegatedProviderOffers_Get')]
        [System.String]
        $ResourceId,
    
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'InputObject_DelegatedProviderOffers_Get')]
        [Microsoft.AzureStack.Management.Subscriptions.Admin.Models.DelegatedProviderOffer]
        $InputObject,
    
        [Parameter(Mandatory = $false, ParameterSetName = 'DelegatedProviderOffers_List')]
        [int]
        $Top = -1
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

    $Offer = $Name

 
    if('InputObject_DelegatedProviderOffers_Get' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_DelegatedProviderOffers_Get' -eq $PsCmdlet.ParameterSetName) {
        $GetArmResourceIdParameterValue_params = @{
            IdTemplate = '/subscriptions/{subscriptionId}/providers/Microsoft.Subscriptions.Admin/delegatedProviders/{delegatedProvider}/offers/{offer}'
        }

        if('ResourceId_DelegatedProviderOffers_Get' -eq $PsCmdlet.ParameterSetName) {
            $GetArmResourceIdParameterValue_params['Id'] = $ResourceId
        }
        else {
            $GetArmResourceIdParameterValue_params['Id'] = $InputObject.Id
        }
        $ArmResourceIdParameterValues = Get-ArmResourceIdParameterValue @GetArmResourceIdParameterValue_params
        $delegatedProvider = $ArmResourceIdParameterValues['delegatedProvider']

        $offer = $ArmResourceIdParameterValues['offer']
    }


    if ('DelegatedProviderOffers_List' -eq $PsCmdlet.ParameterSetName) {
        Write-Verbose -Message 'Performing operation ListWithHttpMessagesAsync on $SubscriptionsAdminClient.'
        $TaskResult = $SubscriptionsAdminClient.DelegatedProviderOffers.ListWithHttpMessagesAsync($DelegatedProvider)
    } elseif ('DelegatedProviderOffers_Get' -eq $PsCmdlet.ParameterSetName -or 'InputObject_DelegatedProviderOffers_Get' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_DelegatedProviderOffers_Get' -eq $PsCmdlet.ParameterSetName) {
        Write-Verbose -Message 'Performing operation GetWithHttpMessagesAsync on $SubscriptionsAdminClient.'
        $TaskResult = $SubscriptionsAdminClient.DelegatedProviderOffers.GetWithHttpMessagesAsync($DelegatedProvider, $Offer)
    } else {
        Write-Verbose -Message 'Failed to map parameter set to operation method.'
        throw 'Module failed to find operation to execute.'
    }

    if ($TaskResult) {
        $GetTaskResult_params = @{
            TaskResult = $TaskResult
        }

        $TopInfo = @{
            'Count' = 0
            'Max' = $Top
        }
        $GetTaskResult_params['TopInfo'] = $TopInfo 
        $SkipInfo = @{
            'Count' = 0
            'Max' = $Skip
        }
        $GetTaskResult_params['SkipInfo'] = $SkipInfo 
        $PageResult = @{
            'Result' = $null
        }
        $GetTaskResult_params['PageResult'] = $PageResult 
        $GetTaskResult_params['PageType'] = 'Microsoft.Rest.Azure.IPage[Microsoft.AzureStack.Management.Subscriptions.Admin.Models.DelegatedProviderOffer]' -as [Type]            
        Get-TaskResult @GetTaskResult_params
            
        Write-Verbose -Message 'Flattening paged results.'
        while ($PageResult -and $PageResult.Result -and (Get-Member -InputObject $PageResult.Result -Name 'nextLink') -and $PageResult.Result.'nextLink' -and (($TopInfo -eq $null) -or ($TopInfo.Max -eq -1) -or ($TopInfo.Count -lt $TopInfo.Max))) {
            $PageResult.Result = $null
            Write-Debug -Message "Retrieving next page: $($PageResult.Result.'nextLink')"
            $TaskResult = $SubscriptionsAdminClient.DelegatedProviderOffers.ListNextWithHttpMessagesAsync($PageResult.Result.'nextLink')
            $GetTaskResult_params['TaskResult'] = $TaskResult
            $GetTaskResult_params['PageResult'] = $PageResult
            Get-TaskResult @GetTaskResult_params
        }
    }
    }

    End {
        if ($tracerObject) {
            $global:DebugPreference = $oldDebugPreference
            Unregister-PSSwaggerClientTracing -TracerObject $tracerObject
        }
    }
}

