<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    Get the list of available updates.

.DESCRIPTION
    Get the list of available updates.  Updates returned from this module may be piped to 'Install-AzsUpdate', if applicable.

.PARAMETER Location
    The name of the update location.

.PARAMETER Skip
    Skip the first N items as specified by the parameter value.

.PARAMETER Top
    Return the top N items as specified by the parameter value. Applies after the -Skip parameter.

.PARAMETER ResourceId
    The resource id.

.PARAMETER ResourceGroupName
    The resource group the resource is located under.

.PARAMETER InputObject
    The input object of type Microsoft.AzureStack.Management.Update.Admin.Models.Update.

.PARAMETER UpdateName
    Name of the update.

.EXAMPLE
	PS C:\> Get-AzsUpdate | ft

	DateAvailable        InstalledDate       Description             State     KbLink                          MinVersionRequired PackagePath
	-------------        -------------       -----------             -----     ------                          ------------------ -----------
	1/1/0001 12:00:00 AM 3/3/2018 8:09:12 AM MAS Update 1.0.180302.1 Installed https://aka.ms/azurestackupdate 1.0.180103.2       \\SU1FileServer\SU1_Infr...
	1/1/0001 12:00:00 AM                     AzS Update 1.0.180305.1 Ready     https://aka.ms/azurestackupdate 1.0.180103.2       https://updateadminaccou...

.EXAMPLE
	PS C:\> Get-AzsUpdate -UpdateName Microsoft1.0.180305.1

	DateAvailable      : 1/1/0001 12:00:00 AM
	InstalledDate      :
	Description        : AzS Update 1.0.180305.1
	State              : Ready
	KbLink             : https://aka.ms/azurestackupdate
	MinVersionRequired : 1.0.180103.2
	PackagePath        : https://updateadminaccount.blob.location.company.com/180305
	PackageSizeInMb    : 2954
	UpdateName         : AzS Update - 1.0.180305.1
	Version            : 1.0.180305.1
	...

#>
function Get-AzsUpdate {
    [OutputType([Microsoft.AzureStack.Management.Update.Admin.Models.Update])]
    [CmdletBinding(DefaultParameterSetName = 'Updates_List')]
    param(
        [Parameter(Mandatory = $false, ParameterSetName = 'Updates_List')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Updates_Get')]
        [System.String]
        $Location,

        [Parameter(Mandatory = $false, ParameterSetName = 'Updates_List')]
        [int]
        $Skip = -1,

        [Parameter(Mandatory = $false, ParameterSetName = 'Updates_List')]
        [int]
        $Top = -1,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'ResourceId_Updates_Get')]
        [System.String]
        $ResourceId,

        [Parameter(Mandatory = $false, ParameterSetName = 'Updates_List')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Updates_Get')]
        [System.String]
        $ResourceGroupName,

        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'InputObject_Updates_Get')]
        [Microsoft.AzureStack.Management.Update.Admin.Models.Update]
        $InputObject,

        [Parameter(Mandatory = $true, ParameterSetName = 'Updates_Get')]
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
            FullClientTypeName = 'Microsoft.AzureStack.Management.Update.Admin.UpdateAdminClient'
        }

        $GlobalParameterHashtable = @{}
        $NewServiceClient_params['GlobalParameterHashtable'] = $GlobalParameterHashtable

        $GlobalParameterHashtable['SubscriptionId'] = $null
        if ($PSBoundParameters.ContainsKey('SubscriptionId')) {
            $GlobalParameterHashtable['SubscriptionId'] = $PSBoundParameters['SubscriptionId']
        }

        if ( -not $PSBoundParameters.ContainsKey('Location')) {
            $Location = (Get-AzureRMLocation).Location
        }

        $UpdateAdminClient = New-ServiceClient @NewServiceClient_params

        if ('InputObject_Updates_Get' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_Updates_Get' -eq $PsCmdlet.ParameterSetName) {
            $GetArmResourceIdParameterValue_params = @{
                IdTemplate = '/subscriptions/{subscriptionId}/resourcegroups/{resourceGroup}/providers/Microsoft.Update.Admin/updateLocations/{updateLocation}/updates/{update}'
            }

            if ('ResourceId_Updates_Get' -eq $PsCmdlet.ParameterSetName) {
                $GetArmResourceIdParameterValue_params['Id'] = $ResourceId
            } else {
                $GetArmResourceIdParameterValue_params['Id'] = $InputObject.Id
            }
            $ArmResourceIdParameterValues = Get-ArmResourceIdParameterValue @GetArmResourceIdParameterValue_params

            $ResourceGroupName = $ArmResourceIdParameterValues['resourceGroup']
            $Location = $ArmResourceIdParameterValues['updateLocation']
            $Name = $ArmResourceIdParameterValues['update']
        } else {
            if (-not $PSBoundParameters.ContainsKey('Location')) {
                $Location = (Get-AzureRmLocation).Location
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
            Write-Verbose -Message 'Performing server-side call ''Get-AzsUpdate -'''
            $serverSideCall_params = @{
            }

            $serverSideResults = Get-AzsUpdate @serverSideCall_params
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
        if ('Updates_List' -eq $PsCmdlet.ParameterSetName) {
            Write-Verbose -Message 'Performing operation ListWithHttpMessagesAsync on $UpdateAdminClient.'
            $TaskResult = $UpdateAdminClient.Updates.ListWithHttpMessagesAsync($ResourceGroupName, $Location)
        } elseif ('Updates_Get' -eq $PsCmdlet.ParameterSetName -or 'InputObject_Updates_Get' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_Updates_Get' -eq $PsCmdlet.ParameterSetName) {
            Write-Verbose -Message 'Performing operation GetWithHttpMessagesAsync on $UpdateAdminClient.'
            $TaskResult = $UpdateAdminClient.Updates.GetWithHttpMessagesAsync($ResourceGroupName, $Location, $Name)
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
            $GetTaskResult_params['PageType'] = 'Microsoft.Rest.Azure.IPage[Microsoft.AzureStack.Management.Update.Admin.Models.Update]' -as [Type]
            Get-TaskResult @GetTaskResult_params

            Write-Verbose -Message 'Flattening paged results.'
            while ($PageResult -and $PageResult.Result -and (Get-Member -InputObject $PageResult.Result -Name 'nextLink') -and $PageResult.Result.'nextLink' -and (($TopInfo -eq $null) -or ($TopInfo.Max -eq -1) -or ($TopInfo.Count -lt $TopInfo.Max))) {
                $PageResult.Result = $null
                Write-Debug -Message "Retrieving next page: $($PageResult.Result.'nextLink')"
                $TaskResult = $UpdateAdminClient.Updates.ListNextWithHttpMessagesAsync($PageResult.Result.'nextLink')
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

