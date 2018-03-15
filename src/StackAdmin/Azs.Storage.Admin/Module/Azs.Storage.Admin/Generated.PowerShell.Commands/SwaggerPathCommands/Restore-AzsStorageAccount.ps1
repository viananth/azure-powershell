<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    Undelete a deleted storage account.

.DESCRIPTION
    Undelete a deleted storage account.

.PARAMETER InputObject
    The input object of type Microsoft.AzureStack.Management.Storage.Admin.Models.StorageAccount.

.PARAMETER ResourceGroupName
    Resource group name.

.PARAMETER ResourceId
    The resource id.

.PARAMETER FarmId
    Farm Id.

.PARAMETER Name
    Internal storage account ID, which is not visible to tenant.

.EXAMPLE

    PS C:\> Restore-AzsStorageAccount -FarmId "90987d65-eb60-42ae-b735-18bcd7ff69da" -Name "83fe9ac0-f1e7-433e-b04c-c61ae0712093"
#>
function Restore-AzsStorageAccount {
    [CmdletBinding(DefaultParameterSetName = 'StorageAccounts_Undelete')]
    param(
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'InputObject_StorageAccounts_Undelete')]
        [Microsoft.AzureStack.Management.Storage.Admin.Models.StorageAccount]
        $InputObject,

        [Parameter(Mandatory = $false, ParameterSetName = 'StorageAccounts_Undelete')]
        [System.String]
        $ResourceGroupName,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'ResourceId_StorageAccounts_Undelete')]
        [System.String]
        $ResourceId,

        [Parameter(Mandatory = $true, ParameterSetName = 'StorageAccounts_Undelete')]
        [System.String]
        $FarmId,

        [Parameter(Mandatory = $true, ParameterSetName = 'StorageAccounts_Undelete')]
        [System.String]
        $Name
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

        if ('InputObject_StorageAccounts_Undelete' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_StorageAccounts_Undelete' -eq $PsCmdlet.ParameterSetName) {
            $GetArmResourceIdParameterValue_params = @{
                IdTemplate = '/subscriptions/{subscriptionId}/resourcegroups/{resourceGroup}/providers/Microsoft.Storage.Admin/farms/{farmId}/storageaccounts/{accountId}'
            }

            if ('ResourceId_StorageAccounts_Undelete' -eq $PsCmdlet.ParameterSetName) {
                $GetArmResourceIdParameterValue_params['Id'] = $ResourceId
            } else {
                $GetArmResourceIdParameterValue_params['Id'] = $InputObject.Id
            }
            $ArmResourceIdParameterValues = Get-ArmResourceIdParameterValue @GetArmResourceIdParameterValue_params
            $ResourceGroupName = $ArmResourceIdParameterValues['resourceGroup']

            $farmId = $ArmResourceIdParameterValues['farmId']
            $Name = $ArmResourceIdParameterValues['accountId']
        } elseif (-not $PSBoundParameters.ContainsKey('ResourceGroupName')) {
            $ResourceGroupName = "System.$((Get-AzureRmLocation).Location)"
        }


        if ('StorageAccounts_Undelete' -eq $PsCmdlet.ParameterSetName -or 'InputObject_StorageAccounts_Undelete' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_StorageAccounts_Undelete' -eq $PsCmdlet.ParameterSetName) {
            Write-Verbose -Message 'Performing operation UndeleteWithHttpMessagesAsync on $StorageAdminClient.'
            $TaskResult = $StorageAdminClient.StorageAccounts.UndeleteWithHttpMessagesAsync($ResourceGroupName, $FarmId, $Name)
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

