<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    Create a new activation.

.DESCRIPTION
    Create a new activation.

.PARAMETER ResourceId
    The resource id.

.PARAMETER Name
    Name of the activation.

.PARAMETER Activation
    new activation.

.PARAMETER ResourceGroup
    The resource group the resource is located under.

.PARAMETER InputObject
    The input object of type Microsoft.AzureStack.Management.AzureBridge.Admin.Models.ActivationResource.

#>
function New-AzsAzureBridgeActivation {
    [OutputType([Microsoft.AzureStack.Management.AzureBridge.Admin.Models.ActivationResource])]
    [CmdletBinding(DefaultParameterSetName = 'Activations_CreateOrUpdate')]
    param(
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'ResourceId_Activations_CreateOrUpdate')]
        [System.String]
        $ResourceId,

        [Parameter(Mandatory = $true, ParameterSetName = 'Activations_CreateOrUpdate')]
        [System.String]
        $Name,

        [Parameter(Mandatory = $true, ParameterSetName = 'InputObject_Activations_CreateOrUpdate')]
        [Parameter(Mandatory = $true, ParameterSetName = 'ResourceId_Activations_CreateOrUpdate')]
        [Parameter(Mandatory = $true, ParameterSetName = 'Activations_CreateOrUpdate')]
        [Microsoft.AzureStack.Management.AzureBridge.Admin.Models.Activation]
        $Activation,

        [Parameter(Mandatory = $true, ParameterSetName = 'Activations_CreateOrUpdate')]
        [System.String]
        $ResourceGroup,

        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'InputObject_Activations_CreateOrUpdate')]
        [Microsoft.AzureStack.Management.AzureBridge.Admin.Models.ActivationResource]
        $InputObject
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
            FullClientTypeName = 'Microsoft.AzureStack.Management.AzureBridge.Admin.AzureBridgeAdminClient'
        }

        $GlobalParameterHashtable = @{}
        $NewServiceClient_params['GlobalParameterHashtable'] = $GlobalParameterHashtable

        $GlobalParameterHashtable['SubscriptionId'] = $null
        if ($PSBoundParameters.ContainsKey('SubscriptionId')) {
            $GlobalParameterHashtable['SubscriptionId'] = $PSBoundParameters['SubscriptionId']
        }

        $AzureBridgeAdminClient = New-ServiceClient @NewServiceClient_params

        if ('InputObject_Activations_CreateOrUpdate' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_Activations_CreateOrUpdate' -eq $PsCmdlet.ParameterSetName) {
            $GetArmResourceIdParameterValue_params = @{
                IdTemplate = '/subscriptions/{subscriptionId}/resourcegroups/{resourceGroup}/providers/Microsoft.AzureBridge.Admin/activations/{activationName}'
            }

            if ('ResourceId_Activations_CreateOrUpdate' -eq $PsCmdlet.ParameterSetName) {
                $GetArmResourceIdParameterValue_params['Id'] = $ResourceId
            } else {
                $GetArmResourceIdParameterValue_params['Id'] = $InputObject.Id
            }
            $ArmResourceIdParameterValues = Get-ArmResourceIdParameterValue @GetArmResourceIdParameterValue_params

            $resourceGroup = $ArmResourceIdParameterValues['resourceGroup']
            $Name = $ArmResourceIdParameterValues['activationName']
        }

        if ('Activations_CreateOrUpdate' -eq $PsCmdlet.ParameterSetName -or 'InputObject_Activations_CreateOrUpdate' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_Activations_CreateOrUpdate' -eq $PsCmdlet.ParameterSetName) {
            Write-Verbose -Message 'Performing operation CreateOrUpdateWithHttpMessagesAsync on $AzureBridgeAdminClient.'
            $TaskResult = $AzureBridgeAdminClient.Activations.CreateOrUpdateWithHttpMessagesAsync($ResourceGroup, $Name, $Activation)
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

