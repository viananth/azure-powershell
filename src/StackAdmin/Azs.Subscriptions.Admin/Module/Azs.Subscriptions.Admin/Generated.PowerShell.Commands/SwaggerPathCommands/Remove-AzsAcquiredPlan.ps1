<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    Deletes an acquired plan.

.DESCRIPTION
    Deletes an acquired plan.

.PARAMETER PlanAcquisitionId
    The plan acquisition Identifier

.PARAMETER ResourceId
    The resource id.

.PARAMETER TargetSubscriptionId
    The target subscription ID.

.PARAMETER Force
    Flag to remove the item without confirmation.

.EXAMPLE

    Remove-AzsAcquiredPlan -AcquisitionId $([Guid]::NewGuid()) -TargetSubscriptionId "c90173b1-de7a-4b1d-8600-b832b0e65946"

    Delete an acquired plan.
#>
function Remove-AzsAcquiredPlan {
    [CmdletBinding(DefaultParameterSetName = 'Delete', SupportsShouldProcess = $true)]
    param(
        [Parameter(Mandatory = $true, ParameterSetName = 'Delete')]
        [ValidateNotNull()]
        [System.Guid]
        $AcquisitionId,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'ResourceId')]
        [Alias('id')]
        [System.String]
        $ResourceId,

        [Parameter(Mandatory = $true, ParameterSetName = 'Delete')]
        [string]
        $TargetSubscriptionId,

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
            FullClientTypeName = 'Microsoft.AzureStack.Management.Subscriptions.Admin.SubscriptionsAdminClient'
        }

        $GlobalParameterHashtable = @{}
        $NewServiceClient_params['GlobalParameterHashtable'] = $GlobalParameterHashtable

        $GlobalParameterHashtable['SubscriptionId'] = $null
        if ($PSBoundParameters.ContainsKey('SubscriptionId')) {
            $GlobalParameterHashtable['SubscriptionId'] = $PSBoundParameters['SubscriptionId']
        }


        if ('ResourceId' -eq $PsCmdlet.ParameterSetName) {
            $GetArmResourceIdParameterValue_params = @{
                IdTemplate = '/subscriptions/{subscriptionId}/providers/Microsoft.Subscriptions.Admin/subscriptions/{targetSubscriptionId}/acquiredPlans/{planAcquisitionId}'
            }

            $GetArmResourceIdParameterValue_params['Id'] = $ResourceId
            $ArmResourceIdParameterValues = Get-ArmResourceIdParameterValue @GetArmResourceIdParameterValue_params
            $targetSubscriptionId = $ArmResourceIdParameterValues['targetSubscriptionId']
            $AcquisitionId = $ArmResourceIdParameterValues['planAcquisitionId']
        }

        if ($PSCmdlet.ShouldProcess("$AcquisitionId" , "Delete acquired plan")) {
            if (($Force.IsPresent -or $PSCmdlet.ShouldContinue("Delete acquired plan?", "Performing operation DeleteWithHttpMessagesAsync on $AcquisitionId."))) {

                $SubscriptionsAdminClient = New-ServiceClient @NewServiceClient_params

                if ('Delete' -eq $PsCmdlet.ParameterSetName -or 'ResourceId' -eq $PsCmdlet.ParameterSetName) {
                    Write-Verbose -Message 'Performing operation DeleteWithHttpMessagesAsync on $SubscriptionsAdminClient.'
                    $TaskResult = $SubscriptionsAdminClient.AcquiredPlans.DeleteWithHttpMessagesAsync($TargetSubscriptionId, $AcquisitionId.ToString())
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

