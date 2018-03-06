<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    Create or update an existing storage quota.

.DESCRIPTION
    Create or update an existing storage quota.

.PARAMETER CapacityInGb
    Maxium capacity (GB).

.PARAMETER ResourceId
    The resource id.

.PARAMETER NumberOfStorageAccounts
    Total number of storage accounts.

.PARAMETER Location
    Resource location.

.PARAMETER InputObject
    The input object of type Microsoft.AzureStack.Management.Storage.Admin.Models.StorageQuota.

.PARAMETER Name
    The name of the storage quota.

.EXAMPLE
PS C:\> Set-AzsStorageQuota -CapacityInGb 123 -NumberOfStorageAccounts 10 -Location local -Name 'TestUpdateStorageQuota'

	Name       Location   CapacityInGb	NumberOfStorageAccounts
	----       --------   ----------	----------
	local/T... local      123			10

#>
function Set-AzsStorageQuota {
    [OutputType([Microsoft.AzureStack.Management.Storage.Admin.Models.StorageQuota])]
    [CmdletBinding(DefaultParameterSetName = 'StorageQuotas_CreateOrUpdate')]
    param(
        [Parameter(Mandatory = $false)]
        [int32]
        $CapacityInGb,

        [Parameter(Mandatory = $false)]
        [int32]
        $NumberOfStorageAccounts,

        [Parameter(Mandatory = $false, ParameterSetName = 'StorageQuotas_CreateOrUpdate')]
        [System.String]
        $Location,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'ResourceId_StorageQuotas_CreateOrUpdate')]
        [System.String]
        $ResourceId,

        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'InputObject_StorageQuotas_CreateOrUpdate')]
        [Microsoft.AzureStack.Management.Storage.Admin.Models.StorageQuota]
        $InputObject,

        [Parameter(Mandatory = $true, ParameterSetName = 'StorageQuotas_CreateOrUpdate')]
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

        $Quota = $null

        if ('InputObject_StorageQuotas_CreateOrUpdate' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_StorageQuotas_CreateOrUpdate' -eq $PsCmdlet.ParameterSetName) {
            $GetArmResourceIdParameterValue_params = @{
                IdTemplate = '/subscriptions/{subscriptionId}/providers/Microsoft.Storage.Admin/locations/{location}/quotas/{quotaName}'
            }

            if ('ResourceId_StorageQuotas_CreateOrUpdate' -eq $PsCmdlet.ParameterSetName) {
                $GetArmResourceIdParameterValue_params['Id'] = $ResourceId
            } else {
                $GetArmResourceIdParameterValue_params['Id'] = $InputObject.Id
                $Quota = $InputObject
            }
            $ArmResourceIdParameterValues = Get-ArmResourceIdParameterValue @GetArmResourceIdParameterValue_params
            $location = $ArmResourceIdParameterValues['location']

            $Name = $ArmResourceIdParameterValues['quotaName']
        } elseif (-not $PSBoundParameters.ContainsKey('Location')) {
            $Location = (Get-AzureRMLocation).Location
        }

        if ('StorageQuotas_CreateOrUpdate' -eq $PsCmdlet.ParameterSetName -or 'InputObject_StorageQuotas_CreateOrUpdate' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_StorageQuotas_CreateOrUpdate' -eq $PsCmdlet.ParameterSetName) {
            # Get quota if not set
            if ($Quota -eq $null) {
                $Quota = Get-AzsStorageQuota -Location $Location -Name $Name
            }

            # Update the Quota object
            $flattenedParameters = @('CapacityInGb', 'NumberOfStorageAccounts')
            $flattenedParameters | ForEach-Object {
                if ($PSBoundParameters.ContainsKey($_)) {
                    $Quota.$($_) = $PSBoundParameters[$_]
                }
            }

            Write-Verbose -Message 'Performing operation CreateOrUpdateWithHttpMessagesAsync on $StorageAdminClient.'
            $TaskResult = $StorageAdminClient.StorageQuotas.CreateOrUpdateWithHttpMessagesAsync($Location, $Name, $Quota)
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

