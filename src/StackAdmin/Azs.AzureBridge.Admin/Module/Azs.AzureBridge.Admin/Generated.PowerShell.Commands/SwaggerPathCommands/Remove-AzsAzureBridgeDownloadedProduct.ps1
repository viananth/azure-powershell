<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    Delete a product downloaded from Azure MarketPlace.

.DESCRIPTION
    Delete a product downloaded from Azure MarketPlace.

.PARAMETER ActivationName
    Name of the activation.

.PARAMETER ResourceId
    The resource id.

.PARAMETER ResourceGroup
    The resource group the resource is located under.

.PARAMETER InputObject
    The input object of type Microsoft.AzureStack.Management.AzureBridge.Admin.Models.DownloadedProductResource.

.PARAMETER Name
    Name of the product.

#>
function Remove-AzsAzureBridgeDownloadedProduct {
    [OutputType([Microsoft.AzureStack.Management.AzureBridge.Admin.Models.DownloadedProductResource])]
    [CmdletBinding(SupportsShouldProcess = $true)]
    [CmdletBinding(DefaultParameterSetName = 'DownloadedProducts_Delete')]
    param(
        [Parameter(Mandatory = $true, ParameterSetName = 'DownloadedProducts_Delete')]
        [System.String]
        $ActivationName,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'ResourceId_DownloadedProducts_Delete')]
        [System.String]
        $ResourceId,

        [Parameter(Mandatory = $false, ParameterSetName = 'DownloadedProducts_Delete')]
        [System.String]
        $ResourceGroup,

        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'InputObject_DownloadedProducts_Delete')]
        [Microsoft.AzureStack.Management.AzureBridge.Admin.Models.DownloadedProductResource]
        $InputObject,

        [Parameter(Mandatory = $true, ParameterSetName = 'DownloadedProducts_Delete')]
        [Alias('ProductName')]
        [System.String]
        $Name,

        [Parameter(Mandatory = $false)]
        [switch]
        $Force,

        [Parameter(Mandatory = $false)]
        [switch]
        $AsJob
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

        $ProductName = $Name
        if ($PSCmdlet.ShouldProcess("$ProductName" , "Delete the downloaded product")) {
            if (($Force.IsPresent -or $PSCmdlet.ShouldContinue("Delete the downloaded product?", "Performing operation DeleteWithHttpMessagesAsync on $ProductName."))) {

                if ('InputObject_DownloadedProducts_Delete' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_DownloadedProducts_Delete' -eq $PsCmdlet.ParameterSetName) {
                    $GetArmResourceIdParameterValue_params = @{
                        IdTemplate = '/subscriptions/{subscriptionId}/resourcegroups/{resourceGroup}/providers/Microsoft.AzureBridge.Admin/activations/{activationName}/downloadedProducts/{productName}'
                    }

                    if ('ResourceId_DownloadedProducts_Delete' -eq $PsCmdlet.ParameterSetName) {
                        $GetArmResourceIdParameterValue_params['Id'] = $ResourceId
                    }
                    else {
                        $GetArmResourceIdParameterValue_params['Id'] = $InputObject.Id
                    }
                    $ArmResourceIdParameterValues = Get-ArmResourceIdParameterValue @GetArmResourceIdParameterValue_params
                    $resourceGroup = $ArmResourceIdParameterValues['resourceGroup']

                    $activationName = $ArmResourceIdParameterValues['activationName']

                    $productName = $ArmResourceIdParameterValues['productName']
                } elseif (-not $PSBoundParameters.ContainsKey('ResourceGroup'))
                {
                    $ResourceGroup = "System.$(Get-AzureRMLocation)"
                }

                if ('DownloadedProducts_Delete' -eq $PsCmdlet.ParameterSetName -or 'InputObject_DownloadedProducts_Delete' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_DownloadedProducts_Delete' -eq $PsCmdlet.ParameterSetName) {
                    Write-Verbose -Message 'Performing operation DeleteWithHttpMessagesAsync on $AzureBridgeAdminClient.'
                    $TaskResult = $AzureBridgeAdminClient.DownloadedProducts.DeleteWithHttpMessagesAsync($ResourceGroup, $ActivationName, $ProductName)

                }
                else {
                    Write-Verbose -Message 'Failed to map parameter set to operation method.'
                    throw 'Module failed to find operation to execute.'
                }


                Write-Verbose -Message "Waiting for the operation to complete."

                $PSSwaggerJobScriptBlock = {
                    [CmdletBinding()]
                    param(
                        [Parameter(Mandatory = $true)]
                        [System.Threading.Tasks.Task]
                        $TaskResult,

                        [Parameter(Mandatory = $true)]
                        [string]
                        $TaskHelperFilePath
                    )
                    if ($TaskResult) {
                        . $TaskHelperFilePath
                        $GetTaskResult_params = @{
                            TaskResult = $TaskResult
                        }

                        Get-TaskResult @GetTaskResult_params

                    }
                }

                $PSCommonParameters = Get-PSCommonParameter -CallerPSBoundParameters $PSBoundParameters
                $TaskHelperFilePath = Join-Path -Path $ExecutionContext.SessionState.Module.ModuleBase -ChildPath 'Get-TaskResult.ps1'
                if ($AsJob) {
                    $ScriptBlockParameters = New-Object -TypeName 'System.Collections.Generic.Dictionary[string,object]'
                    $ScriptBlockParameters['TaskResult'] = $TaskResult
                    $ScriptBlockParameters['AsJob'] = $AsJob
                    $ScriptBlockParameters['TaskHelperFilePath'] = $TaskHelperFilePath
                    $PSCommonParameters.GetEnumerator() | ForEach-Object { $ScriptBlockParameters[$_.Name] = $_.Value }

                    Start-PSSwaggerJobHelper -ScriptBlock $PSSwaggerJobScriptBlock `
                        -CallerPSBoundParameters $ScriptBlockParameters `
                        -CallerPSCmdlet $PSCmdlet `
                        @PSCommonParameters
                }
                else {
                    Invoke-Command -ScriptBlock $PSSwaggerJobScriptBlock `
                        -ArgumentList $TaskResult, $TaskHelperFilePath `
                        @PSCommonParameters
                }
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

