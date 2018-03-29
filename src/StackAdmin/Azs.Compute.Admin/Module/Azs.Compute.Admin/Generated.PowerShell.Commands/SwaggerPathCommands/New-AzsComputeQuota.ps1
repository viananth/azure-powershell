<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.

Code generated by Microsoft (R) PSSwagger
Changes may cause incorrect behavior and will be lost if the code is regenerated.
#>

<#
.SYNOPSIS
    Create a new compute quota used to limit compute resources.

.DESCRIPTION
    Create a new compute quota.

.PARAMETER Name
    Name of the quota.

.PARAMETER AvailabilitySetCount
    Maximum number of availability sets allowed.

.PARAMETER CoresLimit
    Maximum number of cores allowed.

.PARAMETER VmScaleSetCount
    Maximum number of scale sets allowed.

.PARAMETER VirtualMachineCount
    Maximum number of virtual machines allowed.

.PARAMETER LocationName
    Location of the resource.

.EXAMPLE

    PS C:\> New-AzsComputeQuota -Name testQuota5 -AvailabilitySetCount 1000 -CoresLimit 1000 -VmScaleSetCount 1000 -VirtualMachineCount 1000

    Create a new compute quota.

#>
function New-AzsComputeQuota {
    [OutputType([Microsoft.AzureStack.Management.Compute.Admin.Models.Quota])]
    [CmdletBinding(DefaultParameterSetName = 'Quotas_CreateOrUpdate')]
    param(
        [Parameter(Mandatory = $true, ParameterSetName = 'Quotas_CreateOrUpdate')]
        [System.String]
        $Name,

        [Parameter(Mandatory = $false, ParameterSetName = 'Quotas_CreateOrUpdate')]
        [int32]
        $AvailabilitySetCount = 10,

        [Parameter(Mandatory = $false, ParameterSetName = 'Quotas_CreateOrUpdate')]
        [int32]
        $CoresLimit = 100,

        [Parameter(Mandatory = $false, ParameterSetName = 'Quotas_CreateOrUpdate')]
        [int32]
        $VmScaleSetCount = 100,

        [Parameter(Mandatory = $false, ParameterSetName = 'Quotas_CreateOrUpdate')]
        [int32]
        $VirtualMachineCount = 100,

        [Parameter(Mandatory = $false, ParameterSetName = 'Quotas_CreateOrUpdate')]
        [System.String]
        $Location
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
            FullClientTypeName = 'Microsoft.AzureStack.Management.Compute.Admin.ComputeAdminClient'
        }

        $GlobalParameterHashtable = @{}
        $NewServiceClient_params['GlobalParameterHashtable'] = $GlobalParameterHashtable

        $GlobalParameterHashtable['SubscriptionId'] = $null
        if ($PSBoundParameters.ContainsKey('SubscriptionId')) {
            $GlobalParameterHashtable['SubscriptionId'] = $PSBoundParameters['SubscriptionId']
        }

        $ComputeAdminClient = New-ServiceClient @NewServiceClient_params

        # Default location if missing
        if ( -not $PSBoundParameters.ContainsKey('Location')) {
            $Location = (Get-AzureRmLocation).Location
        }

        # Create object
        $flattenedParameters = @('AvailabilitySetCount', 'CoresLimit', 'VmScaleSetCount', 'VirtualMachineCount', 'Location' )
        $utilityCmdParams = @{}
        $flattenedParameters | ForEach-Object {
            $utilityCmdParams[$_] = Get-Variable -Name $_ -ValueOnly
        }
        $NewQuota = New-QuotaObject @utilityCmdParams

        if ('Quotas_CreateOrUpdate' -eq $PsCmdlet.ParameterSetName) {
            Write-Verbose -Message 'Performing operation CreateOrUpdateWithHttpMessagesAsync on $ComputeAdminClient.'
            $TaskResult = $ComputeAdminClient.Quotas.CreateOrUpdateWithHttpMessagesAsync($Location, $Name, $NewQuota)
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

