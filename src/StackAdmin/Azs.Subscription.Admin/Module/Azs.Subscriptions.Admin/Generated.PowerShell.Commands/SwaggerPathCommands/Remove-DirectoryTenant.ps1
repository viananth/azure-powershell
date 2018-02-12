<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    

.DESCRIPTION
    Delete a directory tenant under a resource group.

.PARAMETER ResourceId
    The resource id.

.PARAMETER ResourceGroup
    The resource group the resource is located under.

.PARAMETER InputObject
    The input object of type Microsoft.AzureStack.Management.Subscriptions.Admin.Models.DirectoryTenant.

.PARAMETER Name
    Directory tenant name.

#>
function Remove-DirectoryTenant
{
    [CmdletBinding(DefaultParameterSetName='DirectoryTenants_Delete')]
    param(    
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'ResourceId_DirectoryTenants_Delete')]
        [System.String]
        $ResourceId,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'DirectoryTenants_Delete')]
        [System.String]
        $ResourceGroup,
    
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'InputObject_DirectoryTenants_Delete')]
        [Microsoft.AzureStack.Management.Subscriptions.Admin.Models.DirectoryTenant]
        $InputObject,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'DirectoryTenants_Delete')]
        [Alias('Tenant')]
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

    $Tenant = $Name

 
    if('InputObject_DirectoryTenants_Delete' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_DirectoryTenants_Delete' -eq $PsCmdlet.ParameterSetName) {
        $GetArmResourceIdParameterValue_params = @{
            IdTemplate = '/subscriptions/{subscriptionId}/resourcegroups/{resourceGroup}/providers/Microsoft.Subscriptions.Admin/directoryTenants/{tenant}'
        }

        if('ResourceId_DirectoryTenants_Delete' -eq $PsCmdlet.ParameterSetName) {
            $GetArmResourceIdParameterValue_params['Id'] = $ResourceId
        }
        else {
            $GetArmResourceIdParameterValue_params['Id'] = $InputObject.Id
        }
        $ArmResourceIdParameterValues = Get-ArmResourceIdParameterValue @GetArmResourceIdParameterValue_params
        $resourceGroup = $ArmResourceIdParameterValues['resourceGroup']

        $tenant = $ArmResourceIdParameterValues['tenant']
    }


    if ('DirectoryTenants_Delete' -eq $PsCmdlet.ParameterSetName -or 'InputObject_DirectoryTenants_Delete' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_DirectoryTenants_Delete' -eq $PsCmdlet.ParameterSetName) {
        Write-Verbose -Message 'Performing operation DeleteWithHttpMessagesAsync on $SubscriptionsAdminClient.'
        $TaskResult = $SubscriptionsAdminClient.DirectoryTenants.DeleteWithHttpMessagesAsync($ResourceGroup, $Tenant)
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

