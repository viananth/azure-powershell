<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    Returns the Azure Bridge Activation.

.DESCRIPTION
    Returns the Azure Bridge Activation.

.PARAMETER Name
    Name of the activation.

.PARAMETER Skip
    Skip the first N items as specified by the parameter value.

.PARAMETER ResourceId
    The resource id.

.PARAMETER ResourceGroup
    The resource group the resource is located under.

.PARAMETER InputObject
    The input object of type Microsoft.AzureStack.Management.AzureBridge.Admin.Models.ActivationResource.

.PARAMETER Top
    Return the top N items as specified by the parameter value. Applies after the -Skip parameter.

#>
function Get-AzsAzureBridgeActivation
{
    [OutputType([Microsoft.AzureStack.Management.AzureBridge.Admin.Models.ActivationResource])]
    [CmdletBinding(DefaultParameterSetName='Activations_List')]
    param(    
        [Parameter(Mandatory = $true, ParameterSetName = 'Activations_Get')]
        [Alias('ActivationName')]
        [System.String]
        $Name,
    
        [Parameter(Mandatory = $false, ParameterSetName = 'Activations_List')]
        [int]
        $Skip = -1,
    
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'ResourceId_Activations_Get')]
        [System.String]
        $ResourceId,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'Activations_Get')]
        [Parameter(Mandatory = $true, ParameterSetName = 'Activations_List')]
        [System.String]
        $ResourceGroup,
    
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'InputObject_Activations_Get')]
        [Microsoft.AzureStack.Management.AzureBridge.Admin.Models.ActivationResource]
        $InputObject,
    
        [Parameter(Mandatory = $false, ParameterSetName = 'Activations_List')]
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
        FullClientTypeName = 'Microsoft.AzureStack.Management.AzureBridge.Admin.AzureBridgeAdminClient'
    }

    $GlobalParameterHashtable = @{}
    $NewServiceClient_params['GlobalParameterHashtable'] = $GlobalParameterHashtable
     
    $GlobalParameterHashtable['SubscriptionId'] = $null
    if($PSBoundParameters.ContainsKey('SubscriptionId')) {
        $GlobalParameterHashtable['SubscriptionId'] = $PSBoundParameters['SubscriptionId']
    }

    $AzureBridgeAdminClient = New-ServiceClient @NewServiceClient_params

    $ActivationName = $Name

 
    if('InputObject_Activations_Get' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_Activations_Get' -eq $PsCmdlet.ParameterSetName) {
        $GetArmResourceIdParameterValue_params = @{
            IdTemplate = '/subscriptions/{subscriptionId}/resourcegroups/{resourceGroup}/providers/Microsoft.AzureBridge.Admin/activations/{activationName}'
        }

        if('ResourceId_Activations_Get' -eq $PsCmdlet.ParameterSetName) {
            $GetArmResourceIdParameterValue_params['Id'] = $ResourceId
        }
        else {
            $GetArmResourceIdParameterValue_params['Id'] = $InputObject.Id
        }
        $ArmResourceIdParameterValues = Get-ArmResourceIdParameterValue @GetArmResourceIdParameterValue_params
        $resourceGroup = $ArmResourceIdParameterValues['resourceGroup']

        $activationName = $ArmResourceIdParameterValues['activationName']
    }


    if ('Activations_List' -eq $PsCmdlet.ParameterSetName) {
        Write-Verbose -Message 'Performing operation ListWithHttpMessagesAsync on $AzureBridgeAdminClient.'
        $TaskResult = $AzureBridgeAdminClient.Activations.ListWithHttpMessagesAsync($ResourceGroup)
    } elseif ('Activations_Get' -eq $PsCmdlet.ParameterSetName -or 'InputObject_Activations_Get' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_Activations_Get' -eq $PsCmdlet.ParameterSetName) {
        Write-Verbose -Message 'Performing operation GetWithHttpMessagesAsync on $AzureBridgeAdminClient.'
        $TaskResult = $AzureBridgeAdminClient.Activations.GetWithHttpMessagesAsync($ResourceGroup, $ActivationName)
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
        $GetTaskResult_params['PageType'] = 'Microsoft.Rest.Azure.IPage[Microsoft.AzureStack.Management.AzureBridge.Admin.Models.ActivationResource]' -as [Type]            
        Get-TaskResult @GetTaskResult_params
            
        Write-Verbose -Message 'Flattening paged results.'
        while ($PageResult -and $PageResult.Result -and (Get-Member -InputObject $PageResult.Result -Name 'nextLink') -and $PageResult.Result.'nextLink' -and (($TopInfo -eq $null) -or ($TopInfo.Max -eq -1) -or ($TopInfo.Count -lt $TopInfo.Max))) {
            $PageResult.Result = $null
            Write-Debug -Message "Retrieving next page: $($PageResult.Result.'nextLink')"
            $TaskResult = $AzureBridgeAdminClient.Activations.ListNextWithHttpMessagesAsync($PageResult.Result.'nextLink')
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

