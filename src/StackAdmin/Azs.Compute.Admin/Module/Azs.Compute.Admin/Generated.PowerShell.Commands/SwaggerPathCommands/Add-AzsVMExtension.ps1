<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    Create a new virtual machine extension image.

.DESCRIPTION
    Create a virtual machine extension image.

.PARAMETER Publisher
    Name of the publisher.

.PARAMETER Type
    Type of extension.

.PARAMETER Version
    The version of the vritual machine image extension.

.PARAMETER SourceBlob
    URI to virtual machine extension package.

.PARAMETER VmOsType
    Target virtual machine operating system type necessary for deploying the extension handler.

.PARAMETER ComputeRole
    The type of role, IaaS or PaaS, this extension supports.

.PARAMETER VmScaleSetEnabled
    Value indicating whether the extension is enabled for virtual machine scale set support.

.PARAMETER SupportMultipleExtensions
    True if supports multiple extensions.

.PARAMETER IsSystemExtension
    Indicates if the extension is for the system.

.PARAMETER Location
    Location of the resource.

.EXAMPLE
PS C:\> Add-AzsVMExtension -Location local -Publisher "Microsoft" -Type "MicroExtension" -Version "0.1.0" -ComputeRole "IaaS" -SourceBlob "https://github.com/Microsoft/PowerShell-DSC-for-Linux/archive/v1.1.1-294.zip" -SupportMultipleExtensions -VmOsType "Linux"
VmOsType                  : Linux
ComputeRole               : N/A
VmScaleSetEnabled         : False
SupportMultipleExtensions : True
IsSystemExtension         : False
SourceBlob                : Microsoft.AzureStack.Management.Compute.Admin.Models.AzureBlob
ProvisioningState         : Creating
Id                        : /subscriptions/0ff0bbbe-d68d-4314-8f68-80a808b5a6ec/providers/Microsoft.Compute.Admin/locations/local/artifactTypes/VMExtension/publishers/Microsoft/types/MicroExtension/versions/0.1.0
Name                      :
Type                      : Microsoft.Compute.Admin/locations/artifactTypes/VMExtension/publishers/types/versions/
Location                  : local

Add a new platform image.

#>
function Add-AzsVMExtension {
    [OutputType([Microsoft.AzureStack.Management.Compute.Admin.Models.VMExtension])]
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [System.String]
        $Publisher,

        [Parameter(Mandatory = $true)]
        [System.String]
        $Type,

        [Parameter(Mandatory = $true)]
        [System.String]
        $Version,

        [Parameter(Mandatory = $true)]
        $SourceBlob,

        [Parameter(Mandatory = $true)]
        [ValidateSet("Unknown", "Windows", "Linux")]
        $VmOsType,

        [Parameter(Mandatory = $true)]
        [string]
        [ValidateSet('IaaS', 'PaaS')]
        $ComputeRole,

        [Parameter(Mandatory = $false)]
        [switch]
        $VmScaleSetEnabled,

        [Parameter(Mandatory = $false)]
        [switch]
        $SupportMultipleExtensions,

        [Parameter(Mandatory = $false)]
        [switch]
        $IsSystemExtension,

        [Parameter(Mandatory = $false)]
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

        Write-Verbose -Message 'Performing operation CreateWithHttpMessagesAsync on $ComputeAdminClient.'
        $TaskResult = $ComputeAdminClient.VMExtensions.CreateWithHttpMessagesAsync($Location, $Publisher, $Type, $Version, $Extension)

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

