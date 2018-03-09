<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    Add a new scale unit.

.DESCRIPTION
    Add a new scale unit.

.PARAMETER ScaleUnitName
    Name of the scale unit.

.PARAMETER NodeList
    List of nodes in the scale unit.

.PARAMETER AwaitStorageConvergence
    Flag indicates if the operation should wait for storage to converge before returning.

.PARAMETER Location
    Location of the resource.

.PARAMETER ResourceGroupName
    Resource group in which the resource provider has been registered.

.PARAMETER ResourceId
    Scale unit node resource ID.

#>
function Add-AzsScaleUnitNode {
    [CmdletBinding(DefaultParameterSetName = 'ScaleOut')]
    param(
        [Parameter(Mandatory = $true, ParameterSetName = 'ScaleOut')]
        [System.String]
        $ScaleUnitName,

        [Parameter(Mandatory = $true, ParameterSetName = 'ScaleOut')]
        [Microsoft.AzureStack.Management.Fabric.Admin.Models.ScaleOutScaleUnitParameters[]]
        $NodeList,

        [Parameter(Mandatory = $false, ParameterSetName = 'ScaleOut')]
        [switch]
        $AwaitStorageConvergence,

        [Parameter(Mandatory = $false, ParameterSetName = 'ScaleOut')]
        [System.String]
        $Location,

        [Parameter(Mandatory = $false, ParameterSetName = 'ScaleOut')]
        [System.String]
        $ResourceGroupName,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'ResourceId')]
        [Alias('id')]
        [System.String]
        $ResourceId,

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
            FullClientTypeName = 'Microsoft.AzureStack.Management.Fabric.Admin.FabricAdminClient'
        }

        $GlobalParameterHashtable = @{}
        $NewServiceClient_params['GlobalParameterHashtable'] = $GlobalParameterHashtable

        $GlobalParameterHashtable['SubscriptionId'] = $null
        if ($PSBoundParameters.ContainsKey('SubscriptionId')) {
            $GlobalParameterHashtable['SubscriptionId'] = $PSBoundParameters['SubscriptionId']
        }

        $flattenedParameters = @('NodeList', 'AwaitStorageConvergence')
        $utilityCmdParams = @{}
        $flattenedParameters | ForEach-Object {
            if ($PSBoundParameters.ContainsKey($_)) {
                $utilityCmdParams[$_] = $PSBoundParameters[$_]
            }
        }

        $ListOfNodeParameters = New-ScaleOutScaleUnitParametersListObject @utilityCmdParams


        $FabricAdminClient = New-ServiceClient @NewServiceClient_params


        if ('ResourceId' -eq $PsCmdlet.ParameterSetName) {
            $GetArmResourceIdParameterValue_params = @{
                IdTemplate = '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Fabric.Admin/fabricLocations/{location}/scaleUnits/{scaleUnit}'
            }

            $GetArmResourceIdParameterValue_params['Id'] = $ResourceId
            $ArmResourceIdParameterValues = Get-ArmResourceIdParameterValue @GetArmResourceIdParameterValue_params

            $ResourceGroupName = $ArmResourceIdParameterValues['resourceGroupName']
            $location = $ArmResourceIdParameterValues['location']
            $ScaleUnitName = $ArmResourceIdParameterValues['scaleUnit']
        } else {
            if (-not $PSBoundParameters.ContainsKey('Location')) {
                $Location = (Get-AzureRMLocation).Location
            }
            if (-not $PSBoundParameters.ContainsKey('ResourceGroupName')) {
                $ResourceGroupName = "System.$Location"
            }
        }

        if ('ScaleOut' -eq $PsCmdlet.ParameterSetName -or "ResourceId" -eq $PsCmdlet.ParameterSetName) {
            Write-Verbose -Message 'Performing operation ScaleOutWithHttpMessagesAsync on $FabricAdminClient.'
            $TaskResult = $FabricAdminClient.ScaleUnits.ScaleOutWithHttpMessagesAsync($ResourceGroupName, $Location, $ScaleUnitName, $ListOfNodeParameters)
        } else {
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
        } else {
            Invoke-Command -ScriptBlock $PSSwaggerJobScriptBlock `
                -ArgumentList $TaskResult, $TaskHelperFilePath `
                @PSCommonParameters
        }
    }

    End {
        if ($tracerObject) {
            $global:DebugPreference = $oldDebugPreference
            Unregister-PSSwaggerClientTracing -TracerObject $tracerObject
        }
    }
}

