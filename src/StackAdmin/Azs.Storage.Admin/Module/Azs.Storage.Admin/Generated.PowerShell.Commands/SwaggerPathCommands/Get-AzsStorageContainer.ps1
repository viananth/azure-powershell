<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    Returns the list of containers which can be migrated in the specified share.

.DESCRIPTION
    Returns the list of containers which can be migrated in the specified share.

.PARAMETER StartIndex
    The start index of get containers.

.PARAMETER ResourceGroupName
    Resource group name.

.PARAMETER ShareName
    Share name which holds the storage containers.

.PARAMETER FarmName
    Farm Id.

.PARAMETER MaxCount
    The max count of containers.

.EXAMPLE

	PS C:\> Get-AzsStorageContainer -ResourceGroupName "system.local" -FarmName f9b8e2e2-e4b4-44e0-9d92-6a848b1a5376 -ShareName "||SU1FileServer.azurestack.local|SU1_ObjStore" -StartIndex 0 -MaxCount 10

	Accountname       Containername     Sharename         ContainerState    UsedBytesInPrimaryVolume
	-----------       -------------     ---------         --------------    -----------------
	srphealthaccount  azurestackheal... \\SU1FileServe... Active            27815936
	srphealthaccount  azurestackheal... \\SU1FileServe... Active            24264704
	frphealthaccount  azurestackheal... \\SU1FileServe... Active            10289152
	srphealthaccount  azurestackheal... \\SU1FileServe... Active            6680576
	srphealthaccount  azurestackheal... \\SU1FileServe... Active            6283264
	hrphealthaccount  azurestackheal... \\SU1FileServe... Active            5160960
	srphealthaccount  storagemetrics... \\SU1FileServe... Active            4390912
	srphealthaccount  storagemetrics... \\SU1FileServe... Active            4378624
	srphealthaccount  azurestackheal... \\SU1FileServe... Active            2760704
	frphealthaccount  azurestackheal... \\SU1FileServe... Active            2260992

    Get a list of containers which can be migrated in the specified share.
#>
function Get-AzsStorageContainer {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [System.String]
        $FarmName,

        [Parameter(Mandatory = $true)]
        [System.String]
        $ShareName,

        [Parameter(Mandatory = $false)]
        [System.String]
        $ResourceGroupName,

        [Parameter(Mandatory = $false)]
        [System.Int32]
        $MaxCount = 100000000,

        [Parameter(Mandatory = $false)]
        [System.Int32]
        $StartIndex = 0
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

        Write-Verbose -Message 'Performing operation ListWithHttpMessagesAsync on $StorageAdminClient.'
        $TaskResult = $StorageAdminClient.Containers.ListWithHttpMessagesAsync($ResourceGroupName, $FarmName, $ShareName, "Migration", $MaxCount, $StartIndex)

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

