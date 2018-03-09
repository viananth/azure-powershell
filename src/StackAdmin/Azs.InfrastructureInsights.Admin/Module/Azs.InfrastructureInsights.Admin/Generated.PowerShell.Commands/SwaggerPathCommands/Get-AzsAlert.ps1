<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    Returns the list of all alerts in a given location.

.DESCRIPTION
    Returns the list of all alerts in a given location.

.PARAMETER Name
    Name of the alert.

.PARAMETER Location
    Name of the location.

.PARAMETER ResourceGroupNameName
    resourceGroupName.

.PARAMETER ResourceId
    The resource id.

.PARAMETER Filter
    OData filter parameter.

.PARAMETER Top
    Return the top N items as specified by the parameter value. Applies after the -Skip parameter.

.PARAMETER Skip
    Skip the first N items as specified by the parameter value.

.EXAMPLE
    PS C:\> Get-AzsAlert -Name 7f58eb8b-e39f-45d0-8ae7-9920b8f22f5f


    ClosedTimestamp                : 
    CreatedTimestamp               : 03/04/2018 05:22:22
    Description                    : {System.Collections.Generic.Dictionary`2[System.String,System.String]}
    FaultId                        : 
    AlertId                        : 7f58eb8b-e39f-45d0-8ae7-9920b8f22f5f
    FaultTypeId                    : CertificateExpiration.ExternalCert.Critical
    LastUpdatedTimestamp           : 03/08/2018 05:22:33
    AlertProperties                : {}
    Remediation                    : {System.Collections.Generic.Dictionary`2[System.String,System.String], 
                                     System.Collections.Generic.Dictionary`2[System.String,System.String], 
                                     System.Collections.Generic.Dictionary`2[System.String,System.String], 
                                     System.Collections.Generic.Dictionary`2[System.String,System.String]...}
    ResourceRegistrationId         : 
    ResourceProviderRegistrationId : e56bc7b8-c8b5-4e25-b00c-4f951effb22c
    Severity                       : Critical
    State                          : Active
    Title                          : Pending external certificate expiration
    ImpactedResourceId             : /subscriptions/df5abebb-3edc-40c5-9155-b4ab239d79d3/resourceGroups/system.local/providers/Microsoft.Fabric.Admin/fabricLocations/local/i
                                     nfraRoleInstances/AZS-CA01
    ImpactedResourceDisplayName    : AZS-CA01
    ClosedByUserAlias              : 
    Id                             : /subscriptions/df5abebb-3edc-40c5-9155-b4ab239d79d3/resourceGroups/System.local/providers/Microsoft.InfrastructureInsights.Admin/regionH
                                     ealths/local/alerts/7f58eb8b-e39f-45d0-8ae7-9920b8f22f5f
    Name                           : 7f58eb8b-e39f-45d0-8ae7-9920b8f22f5f
    Type                           : Microsoft.InfrastructureInsights.Admin/regionHealths/alerts
    Location                       : local
    Tags                           : {}




.EXAMPLE
    PS C:\> $alert = Get-AzsAlert | Where State -EQ 'active'

    PS C:\> $alert.Count
    2

    PS C:\> $alert | select FaultTypeId, Title

    FaultTypeId                                 Title                                  
    -----------                                 -----                                  
    CertificateExpiration.ExternalCert.Critical Pending external certificate expiration
    CertificateExpiration.ExternalCert.Critical Pending external certificate expiration

#>
function Get-AzsAlert {
    [OutputType([Microsoft.AzureStack.Management.InfrastructureInsights.Admin.Models.Alert])]
    [CmdletBinding(DefaultParameterSetName = 'Alerts_List')]
    param(
        [Parameter(Mandatory = $true, ParameterSetName = 'Alerts_Get')]
        [System.String]
        $Name,

        [Parameter(Mandatory = $false, ParameterSetName = 'Alerts_List')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Alerts_Get')]
        [System.String]
        $Location,

        [Parameter(Mandatory = $false, ParameterSetName = 'Alerts_List')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Alerts_Get')]
        [System.String]
        $ResourceGroupName,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'ResourceId_Alerts_Get')]
        [System.String]
        $ResourceId,

        [Parameter(Mandatory = $false, ParameterSetName = 'Alerts_List')]
        [string]
        $Filter,

        [Parameter(Mandatory = $false, ParameterSetName = 'Alerts_List')]
        [int]
        $Top = -1,

        [Parameter(Mandatory = $false, ParameterSetName = 'Alerts_List')]
        [int]
        $Skip = -1
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

        $oDataQuery = ""
        if ($Filter) {
            $oDataQuery += "&`$Filter=$Filter"
        }
        $oDataQuery = $oDataQuery.Trim("&")

        if ('InputObject_Alerts_Get' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_Alerts_Get' -eq $PsCmdlet.ParameterSetName) {
            $GetArmResourceIdParameterValue_params = @{
                IdTemplate = '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.InfrastructureInsights.Admin/regionHealths/{region}/alerts/{alertName}'
            }

            if ('ResourceId_Alerts_Get' -eq $PsCmdlet.ParameterSetName) {
                $GetArmResourceIdParameterValue_params['Id'] = $ResourceId
            } else {
                $GetArmResourceIdParameterValue_params['Id'] = $InputObject.Id
            }
            $ArmResourceIdParameterValues = Get-ArmResourceIdParameterValue @GetArmResourceIdParameterValue_params
            $ResourceGroupName = $ArmResourceIdParameterValues['resourceGroupName']
            $Location = $ArmResourceIdParameterValues['region']
            $Name = $ArmResourceIdParameterValues['alertName']
        } else {
            if (-not $PSBoundParameters.ContainsKey('Location')) {
                $Location = (Get-AzureRMLocation).Location
            }
            if (-not $PSBoundParameters.ContainsKey('ResourceGroupName')) {
                $ResourceGroupName = "System.$Location"
            }
        }

        $filterInfos = @(
            @{
                'Type'     = 'powershellWildcard'
                'Value'    = $Name
                'Property' = 'Name'
            })
        $applicableFilters = Get-ApplicableFilters -Filters $filterInfos
        if ($applicableFilters | Where-Object { $_.Strict }) {
            Write-Verbose -Message 'Performing server-side call ''Get-AzsAlert -'''
            $serverSideCall_params = @{

            }

            $serverSideResults = Get-AzsAlert @serverSideCall_params
            foreach ($serverSideResult in $serverSideResults) {
                $valid = $true
                foreach ($applicableFilter in $applicableFilters) {
                    if (-not (Test-FilteredResult -Result $serverSideResult -Filter $applicableFilter.Filter)) {
                        $valid = $false
                        break
                    }
                }

                if ($valid) {
                    $serverSideResult
                }
            }
            return
        }
        if ('Alerts_List' -eq $PsCmdlet.ParameterSetName) {
            Write-Verbose -Message 'Performing operation ListWithHttpMessagesAsync on $InfrastructureInsightsAdminClient.'
            $TaskResult = $InfrastructureInsightsAdminClient.Alerts.ListWithHttpMessagesAsync($ResourceGroupName, $Location, $(if ($oDataQuery) {
                        New-Object -TypeName "Microsoft.Rest.Azure.OData.ODataQuery``1[Microsoft.AzureStack.Management.InfrastructureInsights.Admin.Models.Alert]" -ArgumentList $oDataQuery
                    } else {
                        $null
                    }))
        } elseif ('Alerts_Get' -eq $PsCmdlet.ParameterSetName -or 'InputObject_Alerts_Get' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_Alerts_Get' -eq $PsCmdlet.ParameterSetName) {
            Write-Verbose -Message 'Performing operation GetWithHttpMessagesAsync on $InfrastructureInsightsAdminClient.'
            $TaskResult = $InfrastructureInsightsAdminClient.Alerts.GetWithHttpMessagesAsync($ResourceGroupName, $Location, $Name)
        } else {
            Write-Verbose -Message 'Failed to map parameter set to operation method.'
            throw 'Module failed to find operation to execute.'
        }

        if ($TaskResult) {
            $GetTaskResult_params = @{
                TaskResult = $TaskResult
            }

            $TopInfo = @{
                'Count' = 0
                'Max'   = $Top
            }
            $GetTaskResult_params['TopInfo'] = $TopInfo
            $SkipInfo = @{
                'Count' = 0
                'Max'   = $Skip
            }
            $GetTaskResult_params['SkipInfo'] = $SkipInfo
            $PageResult = @{
                'Result' = $null
            }
            $GetTaskResult_params['PageResult'] = $PageResult
            $GetTaskResult_params['PageType'] = 'Microsoft.Rest.Azure.IPage[Microsoft.AzureStack.Management.InfrastructureInsights.Admin.Models.Alert]' -as [Type]
            Get-TaskResult @GetTaskResult_params

            Write-Verbose -Message 'Flattening paged results.'
            while ($PageResult -and $PageResult.Result -and (Get-Member -InputObject $PageResult.Result -Name 'nextLink') -and $PageResult.Result.'nextLink' -and (($TopInfo -eq $null) -or ($TopInfo.Max -eq -1) -or ($TopInfo.Count -lt $TopInfo.Max))) {
                $PageResult.Result = $null
                Write-Debug -Message "Retrieving next page: $($PageResult.Result.'nextLink')"
                $TaskResult = $InfrastructureInsightsAdminClient.Alerts.ListNextWithHttpMessagesAsync($PageResult.Result.'nextLink')
                $GetTaskResult_params['TaskResult'] = $TaskResult
                $GetTaskResult_params['PageResult'] = $PageResult
                Get-TaskResult @GetTaskResult_params
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

