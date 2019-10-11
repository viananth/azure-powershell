<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    Parameters for bootstrap action

.DESCRIPTION
    Parameters for bootstrap action

.PARAMETER Version
    Generic Version object

#>
function New-BootStrapActionParametersObject {
    param(    
        [Parameter(Mandatory = $false)]
        [string]
        $Version
    )
    
    $Object = New-Object -TypeName Microsoft.AzureStack.Management.Deployment.Admin.Models.BootStrapActionParameters -ArgumentList @($version)

    if (Get-Member -InputObject $Object -Name Validate -MemberType Method) {
        $Object.Validate()
    }

    return $Object
}

