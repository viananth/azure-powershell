<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    

.DESCRIPTION
    Get the list of update locations.

.PARAMETER Name
    The name of the update location.

.PARAMETER ResourceId
    The resource id.

.PARAMETER ResourceGroup
    The resource group the resource is located under.

.PARAMETER InputObject
    The input object of type Microsoft.AzureStack.Management.Update.Admin.Models.UpdateLocation.

#>
function Get-UpdateLocation
{
    [OutputType([Microsoft.AzureStack.Management.Update.Admin.Models.UpdateLocation])]
    [CmdletBinding(DefaultParameterSetName='UpdateLocations_List')]
    param(    
        [Parameter(Mandatory = $true, ParameterSetName = 'UpdateLocations_Get')]
        [Alias('UpdateLocation')]
        [System.String]
        $Name,
    
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'ResourceId_UpdateLocations_Get')]
        [System.String]
        $ResourceId,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'UpdateLocations_Get')]
        [Parameter(Mandatory = $true, ParameterSetName = 'UpdateLocations_List')]
        [System.String]
        $ResourceGroup,
    
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'InputObject_UpdateLocations_Get')]
        [Microsoft.AzureStack.Management.Update.Admin.Models.UpdateLocation]
        $InputObject
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
        FullClientTypeName = 'Microsoft.AzureStack.Management.Update.Admin.UpdateAdminClient'
    }

    $GlobalParameterHashtable = @{}
    $NewServiceClient_params['GlobalParameterHashtable'] = $GlobalParameterHashtable
     
    $GlobalParameterHashtable['SubscriptionId'] = $null
    if($PSBoundParameters.ContainsKey('SubscriptionId')) {
        $GlobalParameterHashtable['SubscriptionId'] = $PSBoundParameters['SubscriptionId']
    }

    $UpdateAdminClient = New-ServiceClient @NewServiceClient_params

    $UpdateLocation = $Name

 
    if('InputObject_UpdateLocations_Get' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_UpdateLocations_Get' -eq $PsCmdlet.ParameterSetName) {
        $GetArmResourceIdParameterValue_params = @{
            IdTemplate = '/subscriptions/{subscriptionId}/resourcegroups/{resourceGroup}/providers/Microsoft.Update.Admin/updateLocations/{updateLocation}'
        }

        if('ResourceId_UpdateLocations_Get' -eq $PsCmdlet.ParameterSetName) {
            $GetArmResourceIdParameterValue_params['Id'] = $ResourceId
        }
        else {
            $GetArmResourceIdParameterValue_params['Id'] = $InputObject.Id
        }
        $ArmResourceIdParameterValues = Get-ArmResourceIdParameterValue @GetArmResourceIdParameterValue_params
        $resourceGroup = $ArmResourceIdParameterValues['resourceGroup']

        $updateLocation = $ArmResourceIdParameterValues['updateLocation']
    }


    if ('UpdateLocations_List' -eq $PsCmdlet.ParameterSetName) {
        Write-Verbose -Message 'Performing operation ListWithHttpMessagesAsync on $UpdateAdminClient.'
        $TaskResult = $UpdateAdminClient.UpdateLocations.ListWithHttpMessagesAsync($ResourceGroup)
    } elseif ('UpdateLocations_Get' -eq $PsCmdlet.ParameterSetName -or 'InputObject_UpdateLocations_Get' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_UpdateLocations_Get' -eq $PsCmdlet.ParameterSetName) {
        Write-Verbose -Message 'Performing operation GetWithHttpMessagesAsync on $UpdateAdminClient.'
        $TaskResult = $UpdateAdminClient.UpdateLocations.GetWithHttpMessagesAsync($ResourceGroup, $UpdateLocation)
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

