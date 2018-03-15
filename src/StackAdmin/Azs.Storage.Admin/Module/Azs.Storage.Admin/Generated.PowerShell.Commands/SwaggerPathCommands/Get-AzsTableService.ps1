<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    Returns the table servie.

.DESCRIPTION
    Returns the table servie.

.PARAMETER ResourceGroupName
    Resource group name.

.PARAMETER FarmId
    Farm Id.

.EXAMPLE
	PS C:\> Get-AzsTableService -ResourceGroupName "system.local" -FarmId f9b8e2e2-e4b4-44e0-9d92-6a848b1a5376

	Name              Location          Version           HealthStatus
	----              --------          -------           ------------
	f9b8e2e2-e4b4-... local             1.0

#>
function Get-AzsTableService {
    [OutputType([Microsoft.AzureStack.Management.Storage.Admin.Models.TableService])]
    [CmdletBinding(DefaultParameterSetName = 'TableServices_Get')]
    param(
        [Parameter(Mandatory = $false, ParameterSetName = 'TableServices_Get')]
        [System.String]
        $ResourceGroupName,

        [Parameter(Mandatory = $true, ParameterSetName = 'TableServices_Get')]
        [System.String]
        $FarmId
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
            FullClientTypeName = 'Microsoft.AzureStack.Management.Storage.Admin.StorageAdminClient'
        }

        $GlobalParameterHashtable = @{}
        $NewServiceClient_params['GlobalParameterHashtable'] = $GlobalParameterHashtable

        $GlobalParameterHashtable['SubscriptionId'] = $null
        if ($PSBoundParameters.ContainsKey('SubscriptionId')) {
            $GlobalParameterHashtable['SubscriptionId'] = $PSBoundParameters['SubscriptionId']
        }

        $StorageAdminClient = New-ServiceClient @NewServiceClient_params

        if (-not $PSBoundParameters.ContainsKey('ResourceGroupName')) {
            $ResourceGroupName = "System.$((Get-AzureRmLocation).Location)"
        }

        if ('TableServices_Get' -eq $PsCmdlet.ParameterSetName) {
            Write-Verbose -Message 'Performing operation GetWithHttpMessagesAsync on $StorageAdminClient.'
            $TaskResult = $StorageAdminClient.TableServices.GetWithHttpMessagesAsync($ResourceGroupName, $FarmId)
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

