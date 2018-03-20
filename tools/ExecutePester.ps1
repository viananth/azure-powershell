# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

param(
    [Parameter(Mandatory = $false, Position = 0)]
    [switch]$IsNetCore
)

function Start-Tests {
    param(
        [switch]$IsNetCore
    )
    $rootFolder = "$($PSSCriptRoot)\..\src\StackAdmin\"
    $Failures = 0
    $adminModules = Get-ChildItem -Path $rootFolder -Directory -Filter Azs.*
    foreach ($module in $adminModules) {
        $testDir = $module.FullName + "\Tests"
        Push-Location $testDir
        try {
            $result = Invoke-Pester "src" -PassThru
            $Failures += $result.FailedCount
        } catch {
            Write-Error "Pester Test failure, $_"
            break
        }
        Pop-Location
    }
    return $Failures
}

exit (Start-Tests -BuildConfig $BuildConfig -IsNetCore:$IsNetCore)

