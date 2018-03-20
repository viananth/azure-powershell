<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    Returns the requested storage account.

.DESCRIPTION
    Returns the requested storage account.

.PARAMETER Summary
    Switch for wheter summary or detailed information is returned.

.PARAMETER Skip
    Skip the first N items as specified by the parameter value.

.PARAMETER ResourceGroupName
    Resource group name.

.PARAMETER ResourceId
    The resource id.

.PARAMETER FarmName
    Farm Id.

.PARAMETER Name
    Internal storage account ID, which is not visible to tenant.

.PARAMETER Top
    Return the top N items as specified by the parameter value. Applies after the -Skip parameter.

.EXAMPLE
	PS C:\> Get-AzsStorageAccount -ResourceGroupName "system.local" -FarmName f9b8e2e2-e4b4-44e0-9d92-6a848b1a5376 -Summary $false

	AccountTy Name      Location  StatusOfP CreationT AccountSt
	pe                            rimary    ime       atus
	--------- ----      --------  --------- --------- ---------
	Standa... 036578... local     Available 03/05/... Active
	Standa... 091f2b... local     Available 03/05/... Active
	Standa... 0a8951... local     Available 03/05/... Active

#>
function Get-AzsStorageAccount {
    [OutputType([Microsoft.AzureStack.Management.Storage.Admin.Models.StorageAccount])]
    [CmdletBinding(DefaultParameterSetName = 'Get')]
    param(
        [Parameter(Mandatory = $true, ParameterSetName = 'Get')]
        [Parameter(Mandatory = $true, ParameterSetName = 'List')]
        [System.String]
        $FarmName,

        [Parameter(Mandatory = $true, ParameterSetName = 'Get')]
        [System.String]
        $Name,

        [Parameter(Mandatory = $false, ParameterSetName = 'Get')]
        [Parameter(Mandatory = $false, ParameterSetName = 'List')]
        [System.String]
        $ResourceGroupName,

        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'ResourceId')]
        [System.String]
        $ResourceId,

        [Parameter(Mandatory = $false, ParameterSetName = 'List')]
        [Switch]
        $Summary,

        [Parameter(Mandatory = $false, ParameterSetName = 'List')]
        [int]
        $Skip = -1,


        [Parameter(Mandatory = $false, ParameterSetName = 'List')]
        [int]
        $Top = -1
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


        if ('ResourceId' -eq $PsCmdlet.ParameterSetName) {
            $GetArmResourceIdParameterValue_params = @{
                IdTemplate = '/subscriptions/{subscriptionId}/resourcegroups/{resourceGroup}/providers/Microsoft.Storage.Admin/farms/{FarmName}/storageaccounts/{accountId}'
            }

            $GetArmResourceIdParameterValue_params['Id'] = $ResourceId
            $ArmResourceIdParameterValues = Get-ArmResourceIdParameterValue @GetArmResourceIdParameterValue_params

            $ResourceGroupName = $ArmResourceIdParameterValues['resourceGroup']
            $FarmName = $ArmResourceIdParameterValues['FarmName']
            $Name = $ArmResourceIdParameterValues['accountId']

        } elseif (-not $PSBoundParameters.ContainsKey('ResourceGroupName')) {
            $ResourceGroupName = "System.$((Get-AzureRmLocation).Location)"
        }

        if ('List' -eq $PsCmdlet.ParameterSetName) {
            Write-Verbose -Message 'Performing operation ListWithHttpMessagesAsync on $StorageAdminClient.'
            $TaskResult = $StorageAdminClient.StorageAccounts.ListWithHttpMessagesAsync($ResourceGroupName, $FarmName, $Summary.IsPresent)
        } elseif ('Get' -eq $PsCmdlet.ParameterSetName -or 'ResourceId' -eq $PsCmdlet.ParameterSetName) {
            Write-Verbose -Message 'Performing operation GetWithHttpMessagesAsync on $StorageAdminClient.'
            $TaskResult = $StorageAdminClient.StorageAccounts.GetWithHttpMessagesAsync($ResourceGroupName, $FarmName, $Name)
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
            $GetTaskResult_params['PageType'] = 'Microsoft.Rest.Azure.IPage[Microsoft.AzureStack.Management.Storage.Admin.Models.StorageAccount]' -as [Type]
            Get-TaskResult @GetTaskResult_params

            Write-Verbose -Message 'Flattening paged results.'
            while ($PageResult -and $PageResult.Result -and (Get-Member -InputObject $PageResult.Result -Name 'nextLink') -and $PageResult.Result.'nextLink' -and (($TopInfo -eq $null) -or ($TopInfo.Max -eq -1) -or ($TopInfo.Count -lt $TopInfo.Max))) {
                $PageResult.Result = $null
                Write-Debug -Message "Retrieving next page: $($PageResult.Result.'nextLink')"
                $TaskResult = $StorageAdminClient.StorageAccounts.ListNextWithHttpMessagesAsync($PageResult.Result.'nextLink')
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

