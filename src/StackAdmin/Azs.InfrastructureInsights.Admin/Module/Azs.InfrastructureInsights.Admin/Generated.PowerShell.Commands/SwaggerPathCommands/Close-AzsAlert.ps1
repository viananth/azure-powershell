<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    Closes the given alert.

.DESCRIPTION
    Closes the given alert.

.PARAMETER InputObject
    The input object of type Microsoft.AzureStack.Management.InfrastructureInsights.Admin.Models.Alert.

.PARAMETER User
    The username used to perform the operation.

.PARAMETER ResourceId
    The resource id.

.EXAMPLE

    PS C:\> Get-AzsAlert -Name f2147f3d-42ac-4316-8cbc-f0f9c18888b0 | Close-AzsAlert


    ClosedTimestamp                : 03/08/2018 23:27:40
    CreatedTimestamp               : 03/04/2018 05:21:00
    Description                    : {System.Collections.Generic.Dictionary`2[System.String,System.String]}
    FaultId                        : 
    AlertId                        : f2147f3d-42ac-4316-8cbc-f0f9c18888b0
    FaultTypeId                    : CertificateExpiration.ExternalCert.Critical
    LastUpdatedTimestamp           : 03/08/2018 23:27:40
    AlertProperties                : {}
    Remediation                    : {System.Collections.Generic.Dictionary`2[System.String,System.String], 
                                     System.Collections.Generic.Dictionary`2[System.String,System.String], 
                                     System.Collections.Generic.Dictionary`2[System.String,System.String], 
                                     System.Collections.Generic.Dictionary`2[System.String,System.String]...}
    ResourceRegistrationId         : 
    ResourceProviderRegistrationId : e56bc7b8-c8b5-4e25-b00c-4f951effb22c
    Severity                       : Critical
    State                          : Closed
    Title                          : Pending external certificate expiration
    ImpactedResourceId             : /subscriptions/df5abebb-3edc-40c5-9155-b4ab239d79d3/resourceGroups/system.local/providers/Microsoft.Fabric.Admin/fabricLocations/local/i
                                     nfraRoleInstances/AZS-GWY01
    ImpactedResourceDisplayName    : AZS-GWY01
    ClosedByUserAlias              : user@domain.onmicrosoft.com
    Id                             : /subscriptions/df5abebb-3edc-40c5-9155-b4ab239d79d3/resourceGroups/System.local/providers/Microsoft.InfrastructureInsights.Admin/regionH
                                     ealths/local/alerts/f2147f3d-42ac-4316-8cbc-f0f9c18888b0
    Name                           : f2147f3d-42ac-4316-8cbc-f0f9c18888b0
    Type                           : Microsoft.InfrastructureInsights.Admin/regionHealths/alerts
    Location                       : local
    Tags                           : {}

#>
function Close-AzsAlert {
    [OutputType([Microsoft.AzureStack.Management.InfrastructureInsights.Admin.Models.Alert])]
    param(

        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'InputObject_Alerts_Close')]
        [Microsoft.AzureStack.Management.InfrastructureInsights.Admin.Models.Alert]
        $InputObject,

        [Parameter(Mandatory = $false, ParameterSetName = 'InputObject_Alerts_Close')]
        [Parameter(Mandatory = $false, ParameterSetName = 'ResourceId_Alerts_Close')]
        [System.String]
        $User,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'ResourceId_Alerts_Close')]
        [System.String]
        $ResourceId
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
            FullClientTypeName = 'Microsoft.AzureStack.Management.InfrastructureInsights.Admin.InfrastructureInsightsAdminClient'
        }

        $GlobalParameterHashtable = @{}
        $NewServiceClient_params['GlobalParameterHashtable'] = $GlobalParameterHashtable

        $GlobalParameterHashtable['SubscriptionId'] = $null
        if ($PSBoundParameters.ContainsKey('SubscriptionId')) {
            $GlobalParameterHashtable['SubscriptionId'] = $PSBoundParameters['SubscriptionId']
        }

        $InfrastructureInsightsAdminClient = New-ServiceClient @NewServiceClient_params

        if ('InputObject_Alerts_Close' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_Alerts_Close' -eq $PsCmdlet.ParameterSetName) {
            $GetArmResourceIdParameterValue_params = @{
                IdTemplate = '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.InfrastructureInsights.Admin/regionHealths/{region}/alerts/{alertName}'
            }

            if ('ResourceId_Alerts_Close' -eq $PsCmdlet.ParameterSetName) {
                $GetArmResourceIdParameterValue_params['Id'] = $ResourceId
                $Alert = Get-AzsAlert -ResourceId $ResourceId
            } else {
                $GetArmResourceIdParameterValue_params['Id'] = $InputObject.Id
                $Alert = $InputObject
            }

            $ArmResourceIdParameterValues = Get-ArmResourceIdParameterValue @GetArmResourceIdParameterValue_params

            $ResourceGroupName = $ArmResourceIdParameterValues['resourceGroupName']
            $Location = $ArmResourceIdParameterValues['region']
            $alertName = $ArmResourceIdParameterValues['alertName']

            if (-not $User) {
                $ctx = Get-AzureRmContext
                $User = $ctx.Account.Id
            }
        }


        if ('Alerts_Close' -eq $PsCmdlet.ParameterSetName -or 'InputObject_Alerts_Close' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_Alerts_Close' -eq $PsCmdlet.ParameterSetName) {
            Write-Verbose -Message 'Performing operation CloseWithHttpMessagesAsync on $InfrastructureInsightsAdminClient.'
            $TaskResult = $InfrastructureInsightsAdminClient.Alerts.CloseWithHttpMessagesAsync($ResourceGroupName, $Location, $AlertName, $User, $Alert)
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

