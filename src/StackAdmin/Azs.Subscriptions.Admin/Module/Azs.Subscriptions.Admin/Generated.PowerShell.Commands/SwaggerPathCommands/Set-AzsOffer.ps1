<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    Create or update the offer.

.DESCRIPTION
    Create or update the offer.

.PARAMETER Name
    Name of an offer.

.PARAMETER ResourceId
    The resource id.

.PARAMETER NewOffer
    New offer.

.PARAMETER ResourceGroup
    The resource group the resource is located under.

.PARAMETER InputObject
    The input object of type Microsoft.AzureStack.Management.Subscriptions.Admin.Models.Offer.

#>
function Set-AzsOffer
{
    [OutputType([Microsoft.AzureStack.Management.Subscriptions.Admin.Models.Offer])]
    [CmdletBinding(DefaultParameterSetName='Offers_CreateOrUpdate')]
    param(
        [Parameter(Mandatory = $true, ParameterSetName = 'Offers_CreateOrUpdate')]
        [Alias('Offer')]
        [System.String]
        $Name,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'ResourceId_Offers_CreateOrUpdate')]
        [System.String]
        $ResourceId,

        [Parameter(Mandatory = $true, ParameterSetName = 'ResourceId_Offers_CreateOrUpdate')]
        [Parameter(Mandatory = $true, ParameterSetName = 'InputObject_Offers_CreateOrUpdate')]
        [Parameter(Mandatory = $true, ParameterSetName = 'Offers_CreateOrUpdate')]
        [Microsoft.AzureStack.Management.Subscriptions.Admin.Models.Offer]
        $NewOffer,

        [Parameter(Mandatory = $true, ParameterSetName = 'Offers_CreateOrUpdate')]
        [System.String]
        $ResourceGroup,

        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'InputObject_Offers_CreateOrUpdate')]
        [Microsoft.AzureStack.Management.Subscriptions.Admin.Models.Offer]
        $InputObject
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


    if('InputObject_Offers_CreateOrUpdate' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_Offers_CreateOrUpdate' -eq $PsCmdlet.ParameterSetName) {
        $GetArmResourceIdParameterValue_params = @{
            IdTemplate = '/subscriptions/{subscriptionId}/resourcegroups/{resourceGroup}/providers/Microsoft.Subscriptions.Admin/offers/{offer}'
        }

        if('ResourceId_Offers_CreateOrUpdate' -eq $PsCmdlet.ParameterSetName) {
            $GetArmResourceIdParameterValue_params['Id'] = $ResourceId
        }
        else {
            $GetArmResourceIdParameterValue_params['Id'] = $InputObject.Id
        }
        $ArmResourceIdParameterValues = Get-ArmResourceIdParameterValue @GetArmResourceIdParameterValue_params
        $resourceGroup = $ArmResourceIdParameterValues['resourceGroup']

        $offer = $ArmResourceIdParameterValues['offer']
    }


    if ('Offers_CreateOrUpdate' -eq $PsCmdlet.ParameterSetName -or 'InputObject_Offers_CreateOrUpdate' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_Offers_CreateOrUpdate' -eq $PsCmdlet.ParameterSetName) {
        Write-Verbose -Message 'Performing operation CreateOrUpdateWithHttpMessagesAsync on $SubscriptionsAdminClient.'
        $TaskResult = $SubscriptionsAdminClient.Offers.CreateOrUpdateWithHttpMessagesAsync($ResourceGroup, $Offer, $NewOffer)
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

