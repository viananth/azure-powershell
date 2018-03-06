<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    Apply a specific update at an update location.

.DESCRIPTION
    Apply a specific update at an update location.  After invoked, Get-AzsUpdateRun may be used to modify the progress of the update.

.PARAMETER ResourceGroupName
    The resource group the resource is located under.

.PARAMETER Location
    The name of the update location.

.PARAMETER UpdateName
    Name of the update.

.PARAMETER InputObject
    The input object of type Microsoft.AzureStack.Management.Update.Admin.Models.Update.

.PARAMETER ResourceId
    The resource id.

.EXAMPLE
	PS C:\> Get-AzsUpdate -UpdateName Microsoft1.0.180305.1 | Install-AzsUpdate

	DateAvailable      : 
	InstalledDate      : 
	Description        : 
	State              : InProgress
	KbLink             : 
	MinVersionRequired : 
	PackagePath        : 
	PackageSizeInMb    : 
	UpdateName         : 
	Version            : 
	UpdateOemFile      : 
	Publisher          : 
	PackageType        : 
	Id                 : /subscriptions/23d66fd1-4743-42ff-b391-e29dc51d799e/resourcegroups/System.redmond/providers/Microsoft.Update.Admin/updateLocations/r
						 edmond/updates/Microsoft1.0.180305.1/updateRuns/a6ad672e-097d-4d40-bc00-8d6ebe327246
	Name               : a6ad672e-097d-4d40-bc00-8d6ebe327246
	Type               : Microsoft.Update.Admin/updateLocations/updates/updateRuns
	Location           : redmond
	Tags               : {}


#>
function Install-AzsUpdate {
    [OutputType([Microsoft.AzureStack.Management.Update.Admin.Models.Update])]
    [CmdletBinding(DefaultParameterSetName = 'Updates_Apply')]
    param(
        [Parameter(Mandatory = $false, ParameterSetName = 'Updates_Apply')]
        [System.String]
        $ResourceGroupName,

        [Parameter(Mandatory = $false, ParameterSetName = 'Updates_Apply')]
        [System.String]
        $Location,

        [Parameter(Mandatory = $true, ParameterSetName = 'Updates_Apply')]
        [System.String]
        $UpdateName,

        [Parameter(Mandatory = $false)]
        [switch]
        $AsJob,

        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'InputObject_Updates_Install')]
        [Microsoft.AzureStack.Management.Update.Admin.Models.Update]
        $InputObject,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'ResourceId_Updates_Install')]
        [System.String]
        $ResourceId
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
            FullClientTypeName = 'Microsoft.AzureStack.Management.Update.Admin.UpdateAdminClient'
        }

        $GlobalParameterHashtable = @{}
        $NewServiceClient_params['GlobalParameterHashtable'] = $GlobalParameterHashtable

        $GlobalParameterHashtable['SubscriptionId'] = $null
        if ($PSBoundParameters.ContainsKey('SubscriptionId')) {
            $GlobalParameterHashtable['SubscriptionId'] = $PSBoundParameters['SubscriptionId']
        }

        $UpdateAdminClient = New-ServiceClient @NewServiceClient_params

        if ('InputObject_Updates_Install' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_Updates_Install' -eq $PsCmdlet.ParameterSetName) {
            $GetArmResourceIdParameterValue_params = @{
                IdTemplate = '/subscriptions/{subscriptionId}/resourcegroups/{resourceGroup}/providers/Microsoft.Update.Admin/updateLocations/{updateLocation}/updates/{update}'
            }

            if ('ResourceId_Updates_Get' -eq $PsCmdlet.ParameterSetName) {
                $GetArmResourceIdParameterValue_params['Id'] = $ResourceId
            } else {
                $GetArmResourceIdParameterValue_params['Id'] = $InputObject.Id
            }
            $ArmResourceIdParameterValues = Get-ArmResourceIdParameterValue @GetArmResourceIdParameterValue_params

            $ResourceGroupName = $ArmResourceIdParameterValues['resourceGroup']
            $Location = $ArmResourceIdParameterValues['updateLocation']
            $UpdateName = $ArmResourceIdParameterValues['update']
        } else {
            if (-not $PSBoundParameters.ContainsKey('Location')) {
                $Location = (Get-AzureRmLocation).Location
            }
            if (-not $PSBoundParameters.ContainsKey('ResourceGroupName')) {
                $ResourceGroupName = "System.$Location"
            }
        }

        if ('Updates_Apply' -eq $PsCmdlet.ParameterSetName -or 'InputObject_Updates_Install' -eq $PsCmdlet.ParameterSetName) {
            Write-Verbose -Message 'Performing operation ApplyWithHttpMessagesAsync on $UpdateAdminClient.'
            $TaskResult = $UpdateAdminClient.Updates.ApplyWithHttpMessagesAsync($ResourceGroupName, $Location, $UpdateName)
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

