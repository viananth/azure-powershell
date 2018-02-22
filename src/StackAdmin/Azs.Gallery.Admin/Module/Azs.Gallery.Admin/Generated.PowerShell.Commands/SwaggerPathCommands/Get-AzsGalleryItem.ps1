<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    Lists gallery items.

.DESCRIPTION
    Returns a list of Azure Stack Gallery items

.PARAMETER GalleryItemName
    Identity of the gallery item. Includes publisher name, item name, and may include version separated by period character.

#>
function Get-AzsGalleryItem {
    [OutputType([Microsoft.AzureStack.Management.Gallery.Admin.Models.GalleryItem])]
    [CmdletBinding(DefaultParameterSetName = 'GalleryItems_List')]
    param(    
        [Parameter(Mandatory = $true, ParameterSetName = 'GalleryItems_Get')]
        [System.String]
        $GalleryItemName
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
            FullClientTypeName = 'Microsoft.AzureStack.Management.Gallery.Admin.GalleryAdminClient'
        }

        $GlobalParameterHashtable = @{}
        $NewServiceClient_params['GlobalParameterHashtable'] = $GlobalParameterHashtable
     
        $GlobalParameterHashtable['SubscriptionId'] = $null
        if ($PSBoundParameters.ContainsKey('SubscriptionId')) {
            $GlobalParameterHashtable['SubscriptionId'] = $PSBoundParameters['SubscriptionId']
        }

        $GalleryAdminClient = New-ServiceClient @NewServiceClient_params


        if ('GalleryItems_List' -eq $PsCmdlet.ParameterSetName) {
            Write-Verbose -Message 'Performing operation ListWithHttpMessagesAsync on $GalleryAdminClient.'
            $TaskResult = $GalleryAdminClient.GalleryItems.ListWithHttpMessagesAsync()
        }
        elseif ('GalleryItems_Get' -eq $PsCmdlet.ParameterSetName) {
            Write-Verbose -Message 'Performing operation GetWithHttpMessagesAsync on $GalleryAdminClient.'
            $TaskResult = $GalleryAdminClient.GalleryItems.GetWithHttpMessagesAsync($GalleryItemName)
        }
        else {
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

