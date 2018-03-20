<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    Returns a list of storage shares.

.DESCRIPTION
    Returns a list of storage shares.

.PARAMETER ResourceGroupName
    Resource group name.

.PARAMETER Name
    Share name.

.PARAMETER ResourceId
    The resource id.

.PARAMETER FarmName
    Farm Id.

.EXAMPLE
	PS C:\> Get-AzsStorageShare -ResourceGroupName "system.local" -FarmName f9b8e2e2-e4b4-44e0-9d92-6a848b1a5376

	Name        Location    ShareName   FreeCapacit UsedCapacit TotalCapaci HealthStatu
										y           y           ty          s
	----        --------    ---------   ----------- ----------- ----------- -----------
	f9b8e2e2... local       ||SU1Fil... 25704435... 15773314... 27281766... Healthy


#>
function Get-AzsStorageShare {
    [OutputType([Microsoft.AzureStack.Management.Storage.Admin.Models.Share])]
    [CmdletBinding(DefaultParameterSetName = 'Shares_List')]
    param(
        [Parameter(Mandatory = $true, ParameterSetName = 'Shares_Get')]
        [Parameter(Mandatory = $true, ParameterSetName = 'Shares_List')]
        [System.String]
        $FarmName,

        [Parameter(Mandatory = $true, ParameterSetName = 'Shares_Get')]
        [System.String]
        $Name,

        [Parameter(Mandatory = $false, ParameterSetName = 'Shares_Get')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Shares_List')]
        [System.String]
        $ResourceGroupName,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'ResourceId_Shares_Get')]
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
            FullClientTypeName = 'Microsoft.AzureStack.Management.Storage.Admin.StorageAdminClient'
        }

        $GlobalParameterHashtable = @{}
        $NewServiceClient_params['GlobalParameterHashtable'] = $GlobalParameterHashtable

        $GlobalParameterHashtable['SubscriptionId'] = $null
        if ($PSBoundParameters.ContainsKey('SubscriptionId')) {
            $GlobalParameterHashtable['SubscriptionId'] = $PSBoundParameters['SubscriptionId']
        }

        $StorageAdminClient = New-ServiceClient @NewServiceClient_params

        if ('ResourceId_Shares_Get' -eq $PsCmdlet.ParameterSetName) {
            $GetArmResourceIdParameterValue_params = @{
                IdTemplate = '/subscriptions/{subscriptionId}/resourcegroups/{resourceGroup}/providers/Microsoft.Storage.Admin/farms/{FarmName}/shares/{shareName}'
            }

            $GetArmResourceIdParameterValue_params['Id'] = $ResourceId
            $ArmResourceIdParameterValues = Get-ArmResourceIdParameterValue @GetArmResourceIdParameterValue_params
            $ResourceGroupName = $ArmResourceIdParameterValues['resourceGroup']

            $FarmName = $ArmResourceIdParameterValues['FarmName']

            $Name = $ArmResourceIdParameterValues['shareName']
        } elseif (-not $PSBoundParameters.ContainsKey('ResourceGroupName')) {
            $ResourceGroupName = "System.$((Get-AzureRmLocation).Location)"
        }

        $filterInfos = @(
            @{
                'Type'     = 'powershellWildcard'
                'Value'    = $Name
                'Property' = 'Name'
            })
        $applicableFilters = Get-ApplicableFilters -Filters $filterInfos
        if ($applicableFilters | Where-Object { $_.Strict }) {
            Write-Verbose -Message 'Performing server-side call ''Get-AzsStorageShare -'''
            $serverSideCall_params = @{

            }

            $serverSideResults = Get-AzsStorageShare @serverSideCall_params
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
        if ('Shares_List' -eq $PsCmdlet.ParameterSetName) {
            Write-Verbose -Message 'Performing operation ListWithHttpMessagesAsync on $StorageAdminClient.'
            $TaskResult = $StorageAdminClient.Shares.ListWithHttpMessagesAsync($ResourceGroupName, $FarmName)
        } elseif ('Shares_Get' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_Shares_Get' -eq $PsCmdlet.ParameterSetName) {
            Write-Verbose -Message 'Performing operation GetWithHttpMessagesAsync on $StorageAdminClient.'
            $TaskResult = $StorageAdminClient.Shares.GetWithHttpMessagesAsync($ResourceGroupName, $FarmName, $Name)
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

