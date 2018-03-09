<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.

Code generated by Microsoft (R) PSSwagger
Changes may cause incorrect behavior and will be lost if the code is regenerated.
#>

<#
.SYNOPSIS
    Deletes a virtual machine extension image.

.DESCRIPTION
    Deletes specified virtual machine extension image.

.PARAMETER Publisher
    Name of the publisher.

.PARAMETER Type
    Type of extension.

.PARAMETER Version
    The version of the virtual machine extension image.

.PARAMETER LocationName
    Location of the resource.

.PARAMETER ResourceId
    The resource id.

.EXAMPLE
C:\PS> Remove-AzsPlatformImage -Location "local" -Publisher Canonical -Offer UbuntuServer -Sku 16.04-LTS -Version 0.1.0

#>
function Remove-AzsVMExtension {
    [CmdletBinding(DefaultParameterSetName = 'Delete')]
    [CmdletBinding(SupportsShouldProcess = $true)]
    param(
        [Parameter(Mandatory = $true, ParameterSetName = 'Delete')]
        [System.String]
        $Publisher,

        [Parameter(Mandatory = $true, ParameterSetName = 'Delete')]
        [System.String]
        $Type,

        [Parameter(Mandatory = $true, ParameterSetName = 'Delete')]
        [System.String]
        $Version,

        [Parameter(Mandatory = $false, ParameterSetName = 'Delete')]
        [System.String]
        $Location,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'ResourceId')]
        [Alias('id')]
        [System.String]
        $ResourceId,

        [Parameter(Mandatory = $false)]
        [switch]
        $Force
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

        if ($PSCmdlet.ShouldProcess("$Publisher" , "Delete the VM extension")) {
            if (($Force.IsPresent -or $PSCmdlet.ShouldContinue("Delete the VM extension?", "Performing operation DeleteWithHttpMessagesAsync on $Publisher."))) {

                if ('ResourceId' -eq $PsCmdlet.ParameterSetName) {
                    $GetArmResourceIdParameterValue_params = @{
                        IdTemplate = '/subscriptions/{subscriptionId}/providers/Microsoft.Compute.Admin/locations/{locationName}/artifactTypes/VMExtension/publishers/{publisher}/types/{type}/versions/{version}'
                    }

                    $GetArmResourceIdParameterValue_params['Id'] = $ResourceId
                    $ArmResourceIdParameterValues = Get-ArmResourceIdParameterValue @GetArmResourceIdParameterValue_params

                    $Location = $ArmResourceIdParameterValues['locationName']
                    $publisher = $ArmResourceIdParameterValues['publisher']
                    $type = $ArmResourceIdParameterValues['type']
                    $version = $ArmResourceIdParameterValues['version']
                } elseif ( -not $PSBoundParameters.ContainsKey('Location')) {
                    $Location = (Get-AzureRMLocation).Location
                }


                if ('Delete' -eq $PsCmdlet.ParameterSetName -or 'ResourceId' -eq $PsCmdlet.ParameterSetName) {
                    Write-Verbose -Message 'Performing operation DeleteWithHttpMessagesAsync on $ComputeAdminClient.'
                    $TaskResult = $ComputeAdminClient.VMExtensions.DeleteWithHttpMessagesAsync($Location, $Publisher, $Type, $Version)
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
        }
    }
    End {
        if ($tracerObject) {
            $global:DebugPreference = $oldDebugPreference
            Unregister-PSSwaggerClientTracing -TracerObject $tracerObject
        }
    }
}

