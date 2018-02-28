<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    Create a new virtual machine extension image.

.DESCRIPTION
    Create a Virtual Machine Extension Image.

.PARAMETER Type
    Type of extension.

.PARAMETER Version
    The version of the vritual machine image extension.

.PARAMETER LocationName
    Location of the resource.

.PARAMETER ResourceId
    The resource id.

.PARAMETER Publisher
    Name of the publisher.

.PARAMETER InputObject
    The input object of type Microsoft.AzureStack.Management.Compute.Admin.Models.VMExtension.

.PARAMETER Extension
    Virtual Machine Extension Image creation properties.

#>
function New-AzsComputeVMExtension {
    [OutputType([Microsoft.AzureStack.Management.Compute.Admin.Models.VMExtension])]
    [CmdletBinding(DefaultParameterSetName = 'VMExtensions_Create')]
    param(
        [Parameter(Mandatory = $true, ParameterSetName = 'VMExtensions_Create')]
        [System.String]
        $Type,

        [Parameter(Mandatory = $true, ParameterSetName = 'VMExtensions_Create')]
        [System.String]
        $Version,

        [Parameter(Mandatory = $false, ParameterSetName = 'VMExtensions_Create')]
        [System.String]
        $Location,

        [Parameter(Mandatory = $true, ParameterSetName = 'VMExtensions_Create')]
        [System.String]
        $Publisher,

        [Parameter(Mandatory = $true)]
        $SourceBlob,

        [Parameter(Mandatory = $true)]
        [ValidateSet("Unknown", "Windows", "Linux")]
        $VmOsType,

        [Parameter(Mandatory = $false)]
        [string]
        $ComputeRole,

        [Parameter(Mandatory = $false)]
        [switch]
        $VmScaleSetEnabled,

        [Parameter(Mandatory = $false)]
        [switch]
        $SupportMultipleExtensions,

        [Parameter(Mandatory = $false)]
        [switch]
        $IsSystemExtension
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

        $SourceBlob = New-AzureBlobObject -Uri $SourceBlob

        # Create object
        $utilityCmdParams = @{}
        $utilityCmdParams["SourceBlob"] = $SourceBlob
        $flattenedParameters = @('VmOsType', 'ComputeRole', 'VmScaleSetEnabled', 'SupportMultipleExtensions', 'IsSystemExtension')
        $flattenedParameters | ForEach-Object {
            if ($PSBoundParameters.ContainsKey($_)) {
                $utilityCmdParams[$_] = $PSBoundParameters[$_]
            }
        }
        $Extension = New-VMExtensionParametersObject @utilityCmdParams

        if ( -not $PSBoundParameters.ContainsKey('Location')) {
            $Location = (Get-AzureRMLocation).Location
        }

        if ('VMExtensions_Create' -eq $PsCmdlet.ParameterSetName) {
            Write-Verbose -Message 'Performing operation CreateWithHttpMessagesAsync on $ComputeAdminClient.'
            $TaskResult = $ComputeAdminClient.VMExtensions.CreateWithHttpMessagesAsync($Location, $Publisher, $Type, $Version, $Extension)
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

