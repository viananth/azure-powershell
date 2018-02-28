<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS


.DESCRIPTION
    Create or updates a directory tenant.

.PARAMETER TenantId
    Tenant unique identifier.

.PARAMETER ResourceGroup
    The resource group the resource is located under.

.PARAMETER Location
    Location where resource is location.

.PARAMETER ResourceId
    The resource id.

.PARAMETER InputObject
    The input object of type Microsoft.AzureStack.Management.Subscriptions.Admin.Models.DirectoryTenant.

.PARAMETER Name
    Directory tenant name.

#>
function Set-AzsDirectoryTenant
{
    [OutputType([Microsoft.AzureStack.Management.Subscriptions.Admin.Models.DirectoryTenant])]
    [CmdletBinding(DefaultParameterSetName='DirectoryTenants_CreateOrUpdate')]
    param(
        [Parameter(Mandatory = $false, ParameterSetName = 'InputObject_DirectoryTenants_CreateOrUpdate')]
        [Parameter(Mandatory = $false, ParameterSetName = 'ResourceId_DirectoryTenants_CreateOrUpdate')]
        [Parameter(Mandatory = $false, ParameterSetName = 'DirectoryTenants_CreateOrUpdate')]
        [string]
        $TenantId,

        [Parameter(Mandatory = $true, ParameterSetName = 'InputObject_DirectoryTenants_CreateOrUpdate')]
        [Parameter(Mandatory = $true, ParameterSetName = 'ResourceId_DirectoryTenants_CreateOrUpdate')]
        [Parameter(Mandatory = $true, ParameterSetName = 'DirectoryTenants_CreateOrUpdate')]
        [System.String]
        $ResourceGroupName,

        [Parameter(Mandatory = $false, ParameterSetName = 'InputObject_DirectoryTenants_CreateOrUpdate')]
        [Parameter(Mandatory = $false, ParameterSetName = 'ResourceId_DirectoryTenants_CreateOrUpdate')]
        [Parameter(Mandatory = $false, ParameterSetName = 'DirectoryTenants_CreateOrUpdate')]
        [string]
        $Location,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'ResourceId_DirectoryTenants_CreateOrUpdate')]
        [System.String]
        $ResourceId,

        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'InputObject_DirectoryTenants_CreateOrUpdate')]
        [Microsoft.AzureStack.Management.Subscriptions.Admin.Models.DirectoryTenant]
        $InputObject,

        [Parameter(Mandatory = $true, ParameterSetName = 'DirectoryTenants_CreateOrUpdate')]
        [System.String]
        $Name
    )

    Begin
    {
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
    if($PSBoundParameters.ContainsKey('SubscriptionId')) {
        $GlobalParameterHashtable['SubscriptionId'] = $PSBoundParameters['SubscriptionId']
    }

    $SubscriptionsAdminClient = New-ServiceClient @NewServiceClient_params


    $flattenedParameters = @('TenantId', 'Location')
    $utilityCmdParams = @{}
    $flattenedParameters | ForEach-Object {
        if($PSBoundParameters.ContainsKey($_)) {
            $utilityCmdParams[$_] = $PSBoundParameters[$_]
        }
    }
    $NewTenant = New-DirectoryTenantObject @utilityCmdParams


    $Tenant = $Name


    if('InputObject_DirectoryTenants_CreateOrUpdate' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_DirectoryTenants_CreateOrUpdate' -eq $PsCmdlet.ParameterSetName) {
        $GetArmResourceIdParameterValue_params = @{
            IdTemplate = '/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.Subscriptions.Admin/directoryTenants/{tenant}'
        }

        if('ResourceId_DirectoryTenants_CreateOrUpdate' -eq $PsCmdlet.ParameterSetName) {
            $GetArmResourceIdParameterValue_params['Id'] = $ResourceId
        }
        else {
            $GetArmResourceIdParameterValue_params['Id'] = $InputObject.Id
        }
        $ArmResourceIdParameterValues = Get-ArmResourceIdParameterValue @GetArmResourceIdParameterValue_params
        $resourceGroupName = $ArmResourceIdParameterValues['resourceGroupName']

        $tenant = $ArmResourceIdParameterValues['tenant']
    } elseif (-not $PSBoundParameters.ContainsKey('Location'))
    {
         $Location = (Get-AzureRMLocation).Location
    }


    if ('DirectoryTenants_CreateOrUpdate' -eq $PsCmdlet.ParameterSetName -or 'InputObject_DirectoryTenants_CreateOrUpdate' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_DirectoryTenants_CreateOrUpdate' -eq $PsCmdlet.ParameterSetName) {
        Write-Verbose -Message 'Performing operation CreateOrUpdateWithHttpMessagesAsync on $SubscriptionsAdminClient.'
        $TaskResult = $SubscriptionsAdminClient.DirectoryTenants.CreateOrUpdateWithHttpMessagesAsync($ResourceGroupName, $Tenant, $NewTenant)
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

