<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    Returns a list of each service's health.

.DESCRIPTION
    Returns a list of each service's health.  The AlertSummary property includes details on warning/error counts.

.PARAMETER Filter
    OData filter parameter.

.PARAMETER Location
    Name of the region

.PARAMETER ResourceGroupNameName
    resourceGroupName.

.PARAMETER Skip
    Skip the first N items as specified by the parameter value.

.PARAMETER ResourceId
    The resource id.

.PARAMETER InputObject
    The input object of type Microsoft.AzureStack.Management.InfrastructureInsights.Admin.Models.ServiceHealth.

.PARAMETER Top
    Return the top N items as specified by the parameter value. Applies after the -Skip parameter.

.PARAMETER Name
    Service Health name.

.EXAMPLE
    PS C:\> Get-AzsRPHealth


    AlertSummary      : Microsoft.AzureStack.Management.InfrastructureInsights.Admin.Models.AlertSummary
    HealthState       : Unknown
    NamespaceProperty : Microsoft.Update.Admin
    RegistrationId    : 217c3a8e-b6f1-4c80-b92b-83e92bc65342
    RoutePrefix       : /subscriptions/df5abebb-3edc-40c5-9155-b4ab239d79d3/resourceGroups/system.local/providers/Microsoft.Update.Admin/updateLocations/local
    DisplayName       : Updates
    ServiceLocation   : local
    InfraURI          : /subscriptions/df5abebb-3edc-40c5-9155-b4ab239d79d3/resourceGroups/system.local/providers/Microsoft.Update.Admin/updateLocations/local/infraRoles/Upd
                        ates
    Id                : /subscriptions/df5abebb-3edc-40c5-9155-b4ab239d79d3/resourceGroups/System.local/providers/Microsoft.InfrastructureInsights.Admin/regionHealths/local/
                        serviceHealths/217c3a8e-b6f1-4c80-b92b-83e92bc65342
    Name              : 217c3a8e-b6f1-4c80-b92b-83e92bc65342
    Type              : Microsoft.InfrastructureInsights.Admin/regionHealths/serviceHealths
    Location          : local
    Tags              : {}

.EXAMPLE
    PS C:\> Get-AzsRPHealth -Name "e56bc7b8-c8b5-4e25-b00c-4f951effb22c"


    AlertSummary      : Microsoft.AzureStack.Management.InfrastructureInsights.Admin.Models.AlertSummary
    HealthState       : Critical
    NamespaceProperty : Microsoft.Fabric.Admin
    RegistrationId    : e56bc7b8-c8b5-4e25-b00c-4f951effb22c
    RoutePrefix       : /subscriptions/df5abebb-3edc-40c5-9155-b4ab239d79d3/resourceGroups/system.local/providers/Microsoft.Fabric.Admin/fabricLocations/local
    DisplayName       : Capacity
    ServiceLocation   : local
    InfraURI          : /subscriptions/df5abebb-3edc-40c5-9155-b4ab239d79d3/resourceGroups/system.local/providers/Microsoft.Fabric.Admin/fabricLocations/local/infraRoles/Cap
                        acity
    Id                : /subscriptions/df5abebb-3edc-40c5-9155-b4ab239d79d3/resourceGroups/System.local/providers/Microsoft.InfrastructureInsights.Admin/regionHealths/local/
                        serviceHealths/e56bc7b8-c8b5-4e25-b00c-4f951effb22c
    Name              : e56bc7b8-c8b5-4e25-b00c-4f951effb22c
    Type              : Microsoft.InfrastructureInsights.Admin/regionHealths/serviceHealths
    Location          : local
    Tags              : {}


#>
function Get-AzsRPHealth {
    [OutputType([Microsoft.AzureStack.Management.InfrastructureInsights.Admin.Models.ServiceHealth])]
    [CmdletBinding(DefaultParameterSetName = 'ServiceHealths_List')]
    param(
        [Parameter(Mandatory = $false, ParameterSetName = 'ServiceHealths_List')]
        [string]
        $Filter,

        [Parameter(Mandatory = $false, ParameterSetName = 'ServiceHealths_List')]
        [Parameter(Mandatory = $false, ParameterSetName = 'ServiceHealths_Get')]
        [System.String]
        $Location,

        [Parameter(Mandatory = $false, ParameterSetName = 'ServiceHealths_List')]
        [Parameter(Mandatory = $false, ParameterSetName = 'ServiceHealths_Get')]
        [System.String]
        $ResourceGroupName,

        [Parameter(Mandatory = $false, ParameterSetName = 'ServiceHealths_List')]
        [int]
        $Skip = -1,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'ResourceId_ServiceHealths_Get')]
        [System.String]
        $ResourceId,

        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'InputObject_ServiceHealths_Get')]
        [Microsoft.AzureStack.Management.InfrastructureInsights.Admin.Models.ServiceHealth]
        $InputObject,

        [Parameter(Mandatory = $false, ParameterSetName = 'ServiceHealths_List')]
        [int]
        $Top = -1,

        [Parameter(Mandatory = $true, ParameterSetName = 'ServiceHealths_Get')]
        [Alias('ServiceHealth')]
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

        if ('InputObject_ServiceHealths_Get' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_ServiceHealths_Get' -eq $PsCmdlet.ParameterSetName) {
            $GetArmResourceIdParameterValue_params = @{
                IdTemplate = '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.InfrastructureInsights.Admin/regionHealths/{region}/serviceHealths/{serviceHealth}'
            }

            if ('ResourceId_ServiceHealths_Get' -eq $PsCmdlet.ParameterSetName) {
                $GetArmResourceIdParameterValue_params['Id'] = $ResourceId
            } else {
                $GetArmResourceIdParameterValue_params['Id'] = $InputObject.Id
            }
            $ArmResourceIdParameterValues = Get-ArmResourceIdParameterValue @GetArmResourceIdParameterValue_params

            $ResourceGroupName = $ArmResourceIdParameterValues['resourceGroupName']
            $Location = $ArmResourceIdParameterValues['region']
            $Name = $ArmResourceIdParameterValues['serviceHealth']
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
            Write-Verbose -Message 'Performing server-side call ''Get-AzsRPHealth -'''
            $serverSideCall_params = @{

            }

            $serverSideResults = Get-AzsRPHealth @serverSideCall_params
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
        if ('ServiceHealths_List' -eq $PsCmdlet.ParameterSetName) {
            Write-Verbose -Message 'Performing operation ListWithHttpMessagesAsync on $InfrastructureInsightsAdminClient.'
            $TaskResult = $InfrastructureInsightsAdminClient.ServiceHealths.ListWithHttpMessagesAsync($ResourceGroupName, $Location, $(if ($oDataQuery) {
                        New-Object -TypeName "Microsoft.Rest.Azure.OData.ODataQuery``1[Microsoft.AzureStack.Management.InfrastructureInsights.Admin.Models.ServiceHealth]" -ArgumentList $oDataQuery
                    } else {
                        $null
                    }))
        } elseif ('ServiceHealths_Get' -eq $PsCmdlet.ParameterSetName -or 'InputObject_ServiceHealths_Get' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_ServiceHealths_Get' -eq $PsCmdlet.ParameterSetName) {
            Write-Verbose -Message 'Performing operation GetWithHttpMessagesAsync on $InfrastructureInsightsAdminClient.'
            $TaskResult = $InfrastructureInsightsAdminClient.ServiceHealths.GetWithHttpMessagesAsync($ResourceGroupName, $Location, $Name)
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
            $GetTaskResult_params['PageType'] = 'Microsoft.Rest.Azure.IPage[Microsoft.AzureStack.Management.InfrastructureInsights.Admin.Models.ServiceHealth]' -as [Type]
            Get-TaskResult @GetTaskResult_params

            Write-Verbose -Message 'Flattening paged results.'
            while ($PageResult -and $PageResult.Result -and (Get-Member -InputObject $PageResult.Result -Name 'nextLink') -and $PageResult.Result.'nextLink' -and (($TopInfo -eq $null) -or ($TopInfo.Max -eq -1) -or ($TopInfo.Count -lt $TopInfo.Max))) {
                $PageResult.Result = $null
                Write-Debug -Message "Retrieving next page: $($PageResult.Result.'nextLink')"
                $TaskResult = $InfrastructureInsightsAdminClient.ServiceHealths.ListNextWithHttpMessagesAsync($PageResult.Result.'nextLink')
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

