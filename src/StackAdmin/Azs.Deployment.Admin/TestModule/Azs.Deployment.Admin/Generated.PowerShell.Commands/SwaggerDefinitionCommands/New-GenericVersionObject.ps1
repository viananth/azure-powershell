<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    Represents a version string

.DESCRIPTION
    Represents a version string

.PARAMETER VersionString
    Version string in the format of integers seperated with dots

#>
function New-GenericVersionObject
{
    param(    
        [Parameter(Mandatory = $false)]
        [string]
        $VersionString
    )
    
    $Object = New-Object -TypeName Microsoft.AzureStack.Management.Deployment.Admin.Models.GenericVersion -ArgumentList @($versionString)

    if(Get-Member -InputObject $Object -Name Validate -MemberType Method)
    {
        $Object.Validate()
    }

    return $Object
}

