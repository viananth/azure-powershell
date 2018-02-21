#########################################################################################
#
# Copyright (c) Microsoft Corporation. All rights reserved.
#
# Licensed under the MIT license.
#
# PSSwaggerUtility Module
#
#########################################################################################
Microsoft.PowerShell.Core\Set-StrictMode -Version Latest
Microsoft.PowerShell.Utility\Import-LocalizedData  LocalizedData -filename PSSwaggerUtility.Resources.psd1

<#
.DESCRIPTION
  Gets the content of a file. Removes the signature block, if it exists.

.PARAMETER Path
  Path to the file whose contents should be read.
#>
function Remove-AuthenticodeSignatureBlock {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Path
    )

    $content = Get-Content -Path $Path
    $skip = $false
    foreach ($line in $content) {
