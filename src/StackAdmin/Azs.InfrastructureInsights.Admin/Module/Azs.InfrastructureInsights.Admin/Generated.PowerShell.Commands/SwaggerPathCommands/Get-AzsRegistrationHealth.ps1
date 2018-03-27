<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    Returns a list of each resource's health under a service.

.DESCRIPTION
    Returns a list of each resource's health under a service.

.PARAMETER ServiceRegistrationId
    Service registration id.

.PARAMETER Filter
    OData filter parameter.

.PARAMETER Location
    Name of the region

.PARAMETER ResourceGroupNameName
    resourceGroupName.

.PARAMETER Name
    Resource registration id.

.PARAMETER ResourceId
    The resource id.

.PARAMETER Top
    Return the top N items as specified by the parameter value. Applies after the -Skip parameter.

.PARAMETER Skip
    Skip the first N items as specified by the parameter value.


.EXAMPLE

    PS C:\> Get-AzsRegistrationHealth -ServiceRegistrationId e56bc7b8-c8b5-4e25-b00c-4f951effb22c

    AlertSummary        : Microsoft.AzureStack.Management.InfrastructureInsights.Admin.Models.AlertSummary
    HealthState         : Healthy
    NamespaceProperty   : Microsoft.Fabric.Admin
    RegistrationId      : 0212cac8-242a-4133-8071-90467ac5b598
    RoutePrefix         : /subscriptions/df5abebb-3edc-40c5-9155-b4ab239d79d3/resourceGroups/system.local/providers/Microsoft.Fabric.Admin/fabricLocations/local
    ResourceLocation    : local
    ResourceName        : PortalUser
    ResourceDisplayName : Portal (User)
    ResourceType        : infraRoles
    ResourceURI         : /subscriptions/df5abebb-3edc-40c5-9155-b4ab239d79d3/resourceGroups/system.local/providers/Microsoft.Fabric.Admin/fabricLocations/local/infr
                          aRoles/PortalUser
    RpRegistrationId    : e56bc7b8-c8b5-4e25-b00c-4f951effb22c
    UsageMetrics        : {}
    Id                  : /subscriptions/df5abebb-3edc-40c5-9155-b4ab239d79d3/resourceGroups/System.local/providers/Microsoft.InfrastructureInsights.Admin/regionHeal
                          ths/local/serviceHealths/e56bc7b8-c8b5-4e25-b00c-4f951effb22c/resourceHealths/0212cac8-242a-4133-8071-90467ac5b598
    Name                : 0212cac8-242a-4133-8071-90467ac5b598
    Type                : Microsoft.InfrastructureInsights.Admin/regionHealths/serviceHealths/resourceHealths
    Location            : local
    Tags                : {}
    ...

    Returns a list of each resource's health under a service.

.EXAMPLE

    PS C:\> Get-AzsRPHealth | Where {$_.NamespaceProperty -eq 'Microsoft.Fabric.Admin'} | Get-AzsRegistrationHealth | select ResourceName, HealthState

    ResourceName                       HealthState
    ------------                       -----------
    PortalUser                         Healthy
    AzureResourceManagerUser           Unknown
    SeedRing                           Unknown
    UsageServiceAdmin                  Healthy
    NetworkControllerRing              Healthy
    AzureConsistentStorageRing         Healthy
    GalleryServiceAdmin                Healthy
    ApplicationGateway                 Healthy
    ActiveDirectoryCertificateServices Unknown
    NonPrivilegedApplicationGateway    Healthy
    AzureResourceManagerAdmin          Unknown
    RASGateway                         Healthy
    StorageController                  Healthy
    PortalAdmin                        Healthy
    AzureBridge                        Healthy
    KeyVaultNamingService              Healthy
    KeyVaultDataPlane                  Healthy
    ComputeController                  Healthy
    ActiveDirectoryDomainServices      Healthy
    FabricControllerRing               Healthy
    ServicesController                 Healthy
    InsightsServiceAdmin               Healthy
    UsageBridge                        Healthy
    SubscriptionsServices              Healthy
    ActiveDirectoryFederationServices  Unknown
    KeyVaultInternalDataPlane          Healthy
    AuthorizationServiceAdmin          Healthy
    SLBMultiplexer                     Healthy
    KeyVaultInternalControlPlane       Healthy
    EnterpriseCloudEngine              Healthy
    UsageServiceUser                   Healthy
    HealthMonitoring                   Healthy
    AuthorizationServiceUser           Healthy
    InsightsServiceUser                Healthy
    BackupController                   Healthy
    GalleryServiceUser                 Healthy
    KeyVaultControlPlane               Healthy
    MicrosoftSQLServer                 Unknown

    Returns health status under a for Microsoft.Fabric.Admin.
#>

function Get-AzsRegistrationHealth {
    [OutputType([Microsoft.AzureStack.Management.InfrastructureInsights.Admin.Models.ResourceHealth])]
    [CmdletBinding(DefaultParameterSetName = 'List')]
    param(
        [Parameter(Mandatory = $true, ParameterSetName = 'Get')]
        [Parameter(Mandatory = $true, ParameterSetName = 'List')]
        [System.String]
        $ServiceRegistrationId,

        [Parameter(Mandatory = $true, ParameterSetName = 'Get')]
        [System.String]
        $ResourceRegistrationId,

        [Parameter(Mandatory = $false, ParameterSetName = 'Get')]
        [Parameter(Mandatory = $false, ParameterSetName = 'List')]
        [System.String]
        $Location,

        [Parameter(Mandatory = $false, ParameterSetName = 'Get')]
        [Parameter(Mandatory = $false, ParameterSetName = 'List')]
        [System.String]
        $ResourceGroupName,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'ResourceId')]
        [Alias('id')]
        [System.String]
        $ResourceId,

        [Parameter(Mandatory = $false, ParameterSetName = 'Get')]
        [Parameter(Mandatory = $false, ParameterSetName = 'List')]
        [Parameter(Mandatory = $false, ParameterSetName = 'ResourceId')]
        [string]
        $Filter,

        [Parameter(Mandatory = $false, ParameterSetName = 'List')]
        [int]
        $Top = -1,

        [Parameter(Mandatory = $false, ParameterSetName = 'List')]
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

        if ('ResourceId' -eq $PsCmdlet.ParameterSetName) {
            $GetArmResourceIdParameterValue_params = @{
                IdTemplate = '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.InfrastructureInsights.Admin/regionHealths/{region}/serviceHealths/{serviceRegistrationId}/resourceHealths/{resourceRegistrationId}'
            }
            $GetArmResourceIdParameterValue_params['Id'] = $ResourceId
            $ArmResourceIdParameterValues = Get-ArmResourceIdParameterValue @GetArmResourceIdParameterValue_params

            $ResourceGroupName = $ArmResourceIdParameterValues['resourceGroupName']
            $Location = $ArmResourceIdParameterValues['region']
            $serviceRegistrationId = $ArmResourceIdParameterValues['serviceRegistrationId']
            $resourceRegistrationId = $ArmResourceIdParameterValues['resourceRegistrationId']
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
                'Value'    = $ResourceRegistrationId
                'Property' = 'Name'
            })
        $applicableFilters = Get-ApplicableFilters -Filters $filterInfos
        if ($applicableFilters | Where-Object { $_.Strict }) {
            Write-Verbose -Message 'Performing server-side call ''Get-AzsRegistrationHealth -'''
            $serverSideCall_params = @{

            }

            $serverSideResults = Get-AzsRegistrationHealth @serverSideCall_params
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
        if ('List' -eq $PsCmdlet.ParameterSetName) {
            Write-Verbose -Message 'Performing operation ListWithHttpMessagesAsync on $InfrastructureInsightsAdminClient.'
            $TaskResult = $InfrastructureInsightsAdminClient.ResourceHealths.ListWithHttpMessagesAsync($ResourceGroupName, $Location, $ServiceRegistrationId, $(if ($oDataQuery) {
                        New-Object -TypeName "Microsoft.Rest.Azure.OData.ODataQuery``1[Microsoft.AzureStack.Management.InfrastructureInsights.Admin.Models.ResourceHealth]" -ArgumentList $oDataQuery
                    } else {
                        $null
                    }))
        } elseif ('Get' -eq $PsCmdlet.ParameterSetName -or 'ResourceId' -eq $PsCmdlet.ParameterSetName) {
            Write-Verbose -Message 'Performing operation GetWithHttpMessagesAsync on $InfrastructureInsightsAdminClient.'
            $TaskResult = $InfrastructureInsightsAdminClient.ResourceHealths.GetWithHttpMessagesAsync($ResourceGroupName, $Location, $ServiceRegistrationId, $ResourceRegistrationId, $(if ($PSBoundParameters.ContainsKey('Filter')) {
                        $Filter
                    } else {
                        [NullString]::Value
                    }))
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
            $GetTaskResult_params['PageType'] = 'Microsoft.Rest.Azure.IPage[Microsoft.AzureStack.Management.InfrastructureInsights.Admin.Models.ResourceHealth]' -as [Type]
            Get-TaskResult @GetTaskResult_params

            Write-Verbose -Message 'Flattening paged results.'
            while ($PageResult -and $PageResult.Result -and (Get-Member -InputObject $PageResult.Result -Name 'nextLink') -and $PageResult.Result.'nextLink' -and (($TopInfo -eq $null) -or ($TopInfo.Max -eq -1) -or ($TopInfo.Count -lt $TopInfo.Max))) {
                $PageResult.Result = $null
                Write-Debug -Message "Retrieving next page: $($PageResult.Result.'nextLink')"
                $TaskResult = $InfrastructureInsightsAdminClient.ResourceHealths.ListNextWithHttpMessagesAsync($PageResult.Result.'nextLink')
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

