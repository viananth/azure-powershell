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

.PARAMETER AccountId
    Internal storage account ID, which is not visible to tenant.

.PARAMETER Top
    Return the top N items as specified by the parameter value. Applies after the -Skip parameter.

.EXAMPLE

    PS C:\> Get-AzsStorageAccount -ResourceGroupName "system.local" -FarmName f9b8e2e2-e4b4-44e0-9d92-6a848b1a5376 -Summary $false

    TenantViewId              : /subscriptions/a35a3f50-9f21-4f04-a978-01bc4ad7aa4f/resourcegroups/system.local/providers/Microsoft.Storage/storageaccounts/systemportal
    AccountType               : Standard_LRS
    ProvisioningState         : Succeeded
    PrimaryEndpoints          : {[blob, https://systemportal.blob.local.azurestack.external/], [queue, https://systemportal.queue.local.azurestack.external/], [table, https://systemportal.table.local.azurestack.external/]}
    CreationTime              : 03/25/2018 12:00:05
    AlternateName             :
    PrimaryLocation           : local
    StatusOfPrimary           : Available
    TenantSubscriptionId      : a35a3f50-9f21-4f04-a978-01bc4ad7aa4f
    TenantStorageAccountName  : systemportal
    TenantResourceGroupName   : system.local
    CurrentOperation          : None
    CustomDomain              :
    AcquisitionOperationCount : 0
    DeletedTime               :
    AccountStatus             : Active
    RecoveredTime             :
    RecycledTime              :
    Permissions               : Full
    AccountId                 : fc1cb9b818554f03abbd00adc59890b7
    WacInternalState          : Active
    ResourceAdminApiVersion   :
    Id                        : /subscriptions/a35a3f50-9f21-4f04-a978-01bc4ad7aa4f/resourcegroups/System.local/providers/Microsoft.Storage.Admin/farms/6925d0ee-a2eb-47b3-aeb2-b3cfbf8b2b51/storageaccounts/fc1cb9b818554f03abbd00adc59890b7
    Name                      : fc1cb9b818554f03abbd00adc59890b7
    Type                      : Microsoft.Storage.Admin/storageaccounts
    Location                  : local
    Tags                      :
    ...

    Get a list of storage accounts.

#>
function Get-AzsStorageAccount {
    [OutputType([Microsoft.AzureStack.Management.Storage.Admin.Models.StorageAccount])]
    [CmdletBinding(DefaultParameterSetName = 'List')]
    param(
        [Parameter(Mandatory = $true, ParameterSetName = 'Get')]
        [Parameter(Mandatory = $true, ParameterSetName = 'List')]
        [System.String]
        $FarmName,

        [Parameter(Mandatory = $false, ParameterSetName = 'Get')]
        [System.String]
        $AccountId,

        [Parameter(Mandatory = $false, ParameterSetName = 'Get')]
        [Parameter(Mandatory = $false, ParameterSetName = 'List')]
        [ValidateLength(1, 90)]
        [System.String]
        $ResourceGroupName,

        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'ResourceId')]
        [Alias('id')]
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
            $AccountId = $ArmResourceIdParameterValues['accountId']

        } elseif (-not $PSBoundParameters.ContainsKey('ResourceGroupName')) {
            $ResourceGroupName = "System.$((Get-AzureRmLocation).Location)"
        }

        if ('List' -eq $PsCmdlet.ParameterSetName) {
            Write-Verbose -Message 'Performing operation ListWithHttpMessagesAsync on $StorageAdminClient.'
            $TaskResult = $StorageAdminClient.StorageAccounts.ListWithHttpMessagesAsync($ResourceGroupName, $FarmName, $Summary.IsPresent)
        } elseif ('Get' -eq $PsCmdlet.ParameterSetName -or 'ResourceId' -eq $PsCmdlet.ParameterSetName) {
            Write-Verbose -Message 'Performing operation GetWithHttpMessagesAsync on $StorageAdminClient.'
            $TaskResult = $StorageAdminClient.StorageAccounts.GetWithHttpMessagesAsync($ResourceGroupName, $FarmName, $AccountId)
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

