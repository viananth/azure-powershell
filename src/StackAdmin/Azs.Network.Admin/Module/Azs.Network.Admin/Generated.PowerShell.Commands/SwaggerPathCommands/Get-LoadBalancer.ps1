<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    Get a list of all load balancers.

.DESCRIPTION
    Get a list of all load balancers.

.PARAMETER Filter
    OData filter parameter.

.PARAMETER OrderBy
    OData orderBy parameter.

.PARAMETER Skip
    Skip the first N items as specified by the parameter value.

.PARAMETER Top
    Return the top N items as specified by the parameter value. Applies after the -Skip parameter.

.PARAMETER InlineCount
    OData inline count parameter.

#>
function Get-LoadBalancer
{
    [OutputType([Microsoft.AzureStack.Management.Network.Admin.Models.LoadBalancer])]
    [CmdletBinding(DefaultParameterSetName='LoadBalancers_List')]
    param(
        [Parameter(Mandatory = $false, ParameterSetName = 'LoadBalancers_List')]
        [string]
        $Filter,

        [Parameter(Mandatory = $false, ParameterSetName = 'LoadBalancers_List')]
        [string]
        $OrderBy,

        [Parameter(Mandatory = $false, ParameterSetName = 'LoadBalancers_List')]
        [int]
        $Skip = -1,

        [Parameter(Mandatory = $false, ParameterSetName = 'LoadBalancers_List')]
        [int]
        $Top = -1,

        [Parameter(Mandatory = $false, ParameterSetName = 'LoadBalancers_List')]
        [System.String]
        $InlineCount
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
        FullClientTypeName = 'Microsoft.AzureStack.Management.Network.Admin.NetworkAdminClient'
    }

    $GlobalParameterHashtable = @{}
    $NewServiceClient_params['GlobalParameterHashtable'] = $GlobalParameterHashtable

    $GlobalParameterHashtable['SubscriptionId'] = $null
    if($PSBoundParameters.ContainsKey('SubscriptionId')) {
        $GlobalParameterHashtable['SubscriptionId'] = $PSBoundParameters['SubscriptionId']
    }

    $NetworkAdminClient = New-ServiceClient @NewServiceClient_params



    $oDataQuery = ""
    if ($Filter) { $oDataQuery += "&`$Filter=$Filter" }
    if ($OrderBy) { $oDataQuery += "&`$OrderBy=$OrderBy" }
    $oDataQuery = $oDataQuery.Trim("&")


    if ('LoadBalancers_List' -eq $PsCmdlet.ParameterSetName) {
        Write-Verbose -Message 'Performing operation ListWithHttpMessagesAsync on $NetworkAdminClient.'
        $TaskResult = $NetworkAdminClient.LoadBalancers.ListWithHttpMessagesAsync($(if ($oDataQuery) { New-Object -TypeName "Microsoft.Rest.Azure.OData.ODataQuery``1[Microsoft.AzureStack.Management.Network.Admin.Models.LoadBalancer]" -ArgumentList $oDataQuery } else { $null }), $(if ($PSBoundParameters.ContainsKey('InlineCount')) { $InlineCount } else { [NullString]::Value }))
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
            'Max' = $Top
        }
        $GetTaskResult_params['TopInfo'] = $TopInfo
        $SkipInfo = @{
            'Count' = 0
            'Max' = $Skip
        }
        $GetTaskResult_params['SkipInfo'] = $SkipInfo
        $PageResult = @{
            'Result' = $null
        }
        $GetTaskResult_params['PageResult'] = $PageResult
        $GetTaskResult_params['PageType'] = 'Microsoft.Rest.Azure.IPage[Microsoft.AzureStack.Management.Network.Admin.Models.LoadBalancer]' -as [Type]
        Get-TaskResult @GetTaskResult_params

        Write-Verbose -Message 'Flattening paged results.'
        while ($PageResult -and $PageResult.Result -and (Get-Member -InputObject $PageResult.Result -Name 'nextLink') -and $PageResult.Result.'nextLink' -and (($TopInfo -eq $null) -or ($TopInfo.Max -eq -1) -or ($TopInfo.Count -lt $TopInfo.Max))) {
            $PageResult.Result = $null
            Write-Debug -Message "Retrieving next page: $($PageResult.Result.'nextLink')"
            $TaskResult = $NetworkAdminClient.LoadBalancers.ListNextWithHttpMessagesAsync($PageResult.Result.'nextLink')
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

