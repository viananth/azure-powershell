<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.

Code generated by Microsoft (R) PSSwagger
Changes may cause incorrect behavior and will be lost if the code is regenerated.
#>

<#
.SYNOPSIS
    Update an existing compute quota using the provuded parameters.

.DESCRIPTION
    Update an existing compute quota.

.PARAMETER Location
    Location of the resource.

.PARAMETER AvailabilitySetCount
    Maximum number of availability sets allowed.

.PARAMETER CoresLimit
    Maximum number of core allowed.

.PARAMETER VmScaleSetCount
    Maximum number of scale sets allowed.

.PARAMETER VirtualMachineCount
    Maximum number of virtual machines allowed.

.PARAMETER ResourceId
    The ARM compute quota id.

.PARAMETER InputObject
    This must be an existing compute quota.  If the parameters passed in are set they will overwrite the parameters in this object, otherwise the quota properties will be used.

.PARAMETER Name
    The ARM resource name of the quota.

#>
function Set-AzsComputeQuota {
    [OutputType([Microsoft.AzureStack.Management.Compute.Admin.Models.Quota])]
    [CmdletBinding(DefaultParameterSetName = 'Quotas_CreateOrUpdate')]
    param(

        [Parameter(Mandatory = $false)]
        [System.String]
        $Location,

        [Parameter(Mandatory = $false)]
        [int32]
        $AvailabilitySetCount,

        [Parameter(Mandatory = $false)]
        [int32]
        $CoresLimit,

        [Parameter(Mandatory = $false)]
        [int32]
        $VmScaleSetCount,

        [Parameter(Mandatory = $false)]
        [int32]
        $VirtualMachineCount,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'ResourceId_Quotas_CreateOrUpdate')]
        [System.String]
        $ResourceId,

        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'InputObject_Quotas_CreateOrUpdate')]
        [Microsoft.AzureStack.Management.Compute.Admin.Models.Quota]
        $InputObject,

        [Parameter(Mandatory = $true, ParameterSetName = 'Quotas_CreateOrUpdate')]
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
            FullClientTypeName = 'Microsoft.AzureStack.Management.Compute.Admin.ComputeAdminClient'
        }

        $GlobalParameterHashtable = @{}
        $NewServiceClient_params['GlobalParameterHashtable'] = $GlobalParameterHashtable

        $GlobalParameterHashtable['SubscriptionId'] = $null
        if ($PSBoundParameters.ContainsKey('SubscriptionId')) {
            $GlobalParameterHashtable['SubscriptionId'] = $PSBoundParameters['SubscriptionId']
        }

        $ComputeAdminClient = New-ServiceClient @NewServiceClient_params

        $NewQuota = $null

        if ('InputObject_Quotas_CreateOrUpdate' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_Quotas_CreateOrUpdate' -eq $PsCmdlet.ParameterSetName) {
            $GetArmResourceIdParameterValue_params = @{
                IdTemplate = '/subscriptions/{subscriptionId}/providers/Microsoft.Compute.Admin/locations/{location}/quotas/{quotaName}'
            }

            if ('ResourceId_Quotas_CreateOrUpdate' -eq $PsCmdlet.ParameterSetName) {
                $GetArmResourceIdParameterValue_params['Id'] = $ResourceId
            } else {
                $GetArmResourceIdParameterValue_params['Id'] = $InputObject.Id
                $NewQuota = $InputObject
            }
            $ArmResourceIdParameterValues = Get-ArmResourceIdParameterValue @GetArmResourceIdParameterValue_params

            $Location = $ArmResourceIdParameterValues['location']
            $Name = $ArmResourceIdParameterValues['quotaName']
        } elseif ( -not $PSBoundParameters.ContainsKey('Location')) {
            $Location = (Get-AzureRMLocation).Location
        }

        if ('Quotas_CreateOrUpdate' -eq $PsCmdlet.ParameterSetName -or 'InputObject_Quotas_CreateOrUpdate' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_Quotas_CreateOrUpdate' -eq $PsCmdlet.ParameterSetName) {

            if ($NewQuota -eq $null) {
                Get-AzsComputeQuota -Location $Location -Name $Name
            }

            # Update the Quota object from anything passed in
            $flattenedParameters = @('AvailabilitySetCount', 'CoresLimit', 'VmScaleSetCount', 'VirtualMachineCount' )
            $flattenedParameters | ForEach-Object {
                if ($PSBoundParameters.ContainsKey($_)) {
                    $NewQuota.$($_) = $PSBoundParameters[$_]
                }
            }

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

