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
    [switch]$IsNetCore,
    [Parameter(Mandatory = $false, Position = 1)]
    [string]$BuildConfig,
    [Parameter(Mandatory = $false, Position = 2)]
    [string]$Scope = 'All',
    [Parameter(Mandatory = $false, Position = 3)]
    [string]$ApiKey,
    [Parameter(Mandatory = $false, Position = 4)]
    [string]$RepositoryLocation,
    [Parameter(Mandatory = $false, Position = 5)]
    [string]$NugetExe,
    [Parameter(Mandatory = $false)]
    [ValidateSet("Latest", "Stack")]
    [string]$Profile = "Latest"
)

function Out-FileNoBom {
    param(
        [System.string]$File,
        [System.string]$Text
    )
    $encoding = New-Object System.Text.UTF8Encoding $False
    [System.IO.File]::WriteAllLines($File, $Text, $encoding)
}

#
#   Get the package folder and resourceManagerRoolFolders
#
function Get-Directories {
    [CmdletBinding()]
    param
    (
        [string]$BuildConfig,
        [switch]$IsNetCore
    )

    PROCESS {
        $packageFolder = "$PSScriptRoot\..\src\Package"
        if ($Profile -eq "Stack") {
            $packageFolder = "$PSScriptRoot\..\src\Stack"
        }

        if ($isNetCore) {
            $resourceManagerRootFolder = "$packageFolder\$buildConfig\ResourceManager"
        } else {
            $resourceManagerRootFolder = "$packageFolder\$buildConfig\ResourceManager\AzureResourceManager"
        }
        Write-Output -InputObject $packageFolder, $resourceManagerRootFolder
    }
}

#
#   Get the list of rollup modules, AzureRM and AzureRM.Profile
#
function Get-RollupModules {
    [CmdletBinding()]
    param
    (
        [string]$BuildConfig,
        [string]$Scope,
        [switch]$IsNetCore
    )

    PROCESS {
        $targets = @()

        $packageFolder, $resourceManagerRootFolder = Get-Directories -BuildConfig $BuildConfig -IsNetCore:$IsNetCore

        if (($Scope -eq 'All') -or ($Scope -eq 'AzureRM') -or ($Scope -eq 'Stack')) {
            if ($Profile -eq "Stack") {
                $targets += "$PSScriptRoot\..\src\StackAdmin\AzureRM"
                $targets += "$PSScriptRoot\..\src\StackAdmin\AzureStack"
            }
            if ($IsNetCore) {
                # For .NetCore publish AzureRM.Netcore
                $targets += "$PSScriptRoot\AzureRM.Netcore"
            }
        }
        Write-Output -InputObject $targets
    }
}

#
#   Get the list of admin modules, Azs.Commerce.Admin, Asz.KeyVault.Admin, etc...
#
function Get-AdminModules {
    [CmdletBinding()]
    param
    (
        [string]$BuildConfig,
        [string]$Scope,
        [switch]$IsNetCore
    )

    PROCESS {
        $targets = @()
        if (($Scope -eq 'All') -or ($Scope -eq "Stack")) {
            $packageFolder, $resourceManagerRootFolder = Get-Directories -BuildConfig $BuildConfig

            $resourceManagerModules = Get-ChildItem -Path $resourceManagerRootFolder -Directory -Filter Azs.*
            foreach ($module in $resourceManagerModules) {
                $targets += $module.FullName
            }
        }
        Write-Output -InputObject $targets
    }
}

#
#   Get the list of independent client modules, CRP, SRP, etc...
#
function Get-ClientModules {
    [CmdletBinding()]
    param
    (
        [string]$BuildConfig,
        [string]$Scope,
        [bool]$PublishLocal,
        [string]$Profile = "Latest",
        [switch]$IsNetCore
    )

    PROCESS {
        $targets = @()

        $packageFolder, $resourceManagerRootFolder = Get-Directories -BuildConfig $BuildConfig -IsNetCore:$IsNetCore

        if ((($Scope -eq 'All') -or $PublishLocal -or $Scope -eq "Stack")) {
            if ($IsNetCore) {
                $targets += "$resourceManagerRootFolder\AzureRM.Profile.Netcore"
            } else {
                $targets += "$resourceManagerRootFolder\AzureRM.Profile"
            }
        }

        if (-not $IsNetCore) {
            if (($Scope -eq 'All') -or ($Scope -eq 'AzureStorage') -or ($Scope -eq 'Stack')) {
                $targets += "$packageFolder\$buildConfig\Storage\Azure.Storage"
            }

            if ((($Scope -eq 'All') -or ($Scope -eq 'ServiceManagement')) -and ($Profile -ne "Stack")) {
                $targets += "$packageFolder\$buildConfig\ServiceManagement\Azure"
            }
        }

        $resourceManagerModules = Get-ChildItem -Path $resourceManagerRootFolder -Directory -Exclude Azs.*

        if ($Scope -eq 'All') {
            foreach ($module in $resourceManagerModules) {
                # filter out AzureRM.Profile which always gets published first
                # And "Azure.Storage" which is built out as test dependencies
                if (($module.Name -ne "AzureRM.Profile") -and ($module.Name -ne "Azure.Storage") -and ($module.Name -ne "AzureRM.Profile.Netcore")) {
                    $targets += $module.FullName
                }
            }
        } elseif( $Scope -eq 'Stack') {
            foreach ($module in $resourceManagerModules) {
                if (($module.Name -ne "AzureRM.Profile") -and ($module.Name -ne "Azure.Storage") -and ($module.Name -ne "AzureRM.Profile.Netcore") -and -not ($module.Name -like "*Azs*")) {
                    $targets += $module.FullName
                }
            }
        } elseif (($Scope -ne 'AzureRM') -and ($Scope -ne "ServiceManagement") -and ($Scope -ne "AzureStorage") -and ($Scope -ne "Stack")) {
            $modulePath = Join-Path $resourceManagerRootFolder "AzureRM.$Scope"
            if (Test-Path $modulePath) {
                $targets += $modulePath
            } else {
                Write-Error "Can not find module with name $Scope to publish"
            }
        }
        Write-Verbose ($targets | Out-String)
        Write-Output -InputObject $targets
    }
}

function Set-CopyrightInfo {

    [CmdletBinding()]
    param(
        [string]$Path
    )
    Update-ModuleManifest -Path $Path -Author "Microsoft" -Copyright "Microsoft @$(Get-Date -Format yyyy)" -CompanyName "Microsoft"
}

#
#   Move required module dependencies.
#
function Remove-ModuleDependencies {
    [CmdletBinding()]
    param(
        [string]$Path
    )

    PROCESS {
        $regex = New-Object System.Text.RegularExpressions.Regex "RequiredModules\s*=\s*@\([^\)]+\)"
        $content = (Get-Content -Path $Path) -join "`r`n"
        $text = $regex.Replace($content, "RequiredModules = @()")
        Out-FileNoBom -File $Path -Text $text

        $regex = New-Object System.Text.RegularExpressions.Regex "NestedModules\s*=\s*@\([^\)]+\)"
        $content = (Get-Content -Path $Path) -join "`r`n"
        $text = $regex.Replace($content, "NestedModules = @()")
        $text | Out-File -FilePath $Path
        Out-FileNoBom -File $Path -Text $text
    }
}

#
#   Update licensing
#
function Update-NugetPackage {
    [CmdletBinding()]
    param(
        [string]$BasePath,
        [string]$ModuleName,
        [string]$DirPath,
        [string]$NugetExe
    )

    PROCESS {
        $regex2 = "<requireLicenseAcceptance>false</requireLicenseAcceptance>"

        $relDir = Join-Path $DirPath -ChildPath "_rels"
        $contentPath = Join-Path $DirPath -ChildPath '`[Content_Types`].xml'
        $packPath = Join-Path $DirPath -ChildPath "package"
        $modulePath = Join-Path $DirPath -ChildPath ($ModuleName + ".nuspec")

        # Cleanup
        Remove-Item -Recurse -Path $relDir -Force
        Remove-Item -Recurse -Path $packPath -Force
        Remove-Item -Path $contentPath -Force

        # Create new output
        $content = (Get-Content -Path $modulePath) -join "`r`n"
        $content = $content -replace $regex2, ("<requireLicenseAcceptance>true</requireLicenseAcceptance>")
        Out-FileNoBom -File (Join-Path (Get-Location) $modulePath) -Text $content

        &$NugetExe pack $modulePath -OutputDirectory $BasePath
    }
}

<#

.SYNOPSIS Publish module to local temporary repository.  If no RootModule found create and add new psm1.

.PARAMETER Path
Path to the local module.

.PARAMETER TempRepo
Name of the local temporary repository.

.PARAMETER TempRepoPath
Path to the local temporary repository.

.PARAMETER NugetExe
Path to nuget exectuable.

#>
function Add-Module {
    [CmdletBinding()]
    param(
        [ValidateNotNullOrEmpty()]
        [string]$Path,

        [ValidateNotNullOrEmpty()]
        [string]$TempRepo,

        [ValidateNotNullOrEmpty()]
        [string]$TempRepoPath,

        [ValidateNotNullOrEmpty()]
        [string]$NugetExe
    )

    PROCESS {

        $moduleName = (Get-Item -Path $Path).Name
        $moduleManifest = $moduleName + ".psd1"
        $moduleSourcePath = Join-Path -Path $Path -ChildPath $moduleManifest
        $file = Get-Item $moduleSourcePath
        Import-LocalizedData -BindingVariable ModuleMetadata -BaseDirectory $file.DirectoryName -FileName $file.Name -ErrorAction Stop

        Write-Output "Publishing the module $moduleName"
        Publish-Module -Path $Path -Repository $TempRepo -Force -ErrorAction Stop | Out-Null
        Write-Output "$moduleName published"

        # Create a psm1 and alter psd1 dependencies to allow fine-grained
        # control over assembly loading.  Opt out by definitng a RootModule.
        if ($ModuleMetadata.RootModule) {
            Write-Output "Root module found, done"
            return
        }

        Write-Output "No root module found, creating"

        $moduleVersion = $ModuleMetadata.ModuleVersion.ToString()
        if ($ModuleMetadata.PrivateData.PSData.Prerelease -ne $null) {
            $moduleVersion += ("-" + $ModuleMetadata.PrivateData.PSData.Prerelease -replace "--", "-")
        }

        Write-Output "Changing to local repository directory for module modifications $TempRepoPath"
        Push-Location $TempRepoPath

        try {

            # Paths
            $nupkgPath = Join-Path -Path . -ChildPath ($moduleName + "." + $moduleVersion + ".nupkg")
            $zipPath = Join-Path -Path . -ChildPath ($moduleName + "." + $moduleVersion + ".zip")
            $dirPath = Join-Path -Path . -ChildPath $moduleName
            $unzippedManifest = Join-Path -Path $dirPath -ChildPath ($moduleName + ".psd1")

            # Validate nuget is there
            if (!(Test-Path -Path $nupkgPath)) {
                throw "Module at $nupkgPath in $TempRepoPath does not exist"
            }

            Write-Output "Renaming package $nupkgPath to zip archive $zipPath"
            Rename-Item $nupkgPath $zipPath

            Write-Output "Expanding $zipPath"
            Expand-Archive $zipPath -DestinationPath $dirPath

            Write-Output "Setting copyright information for $unzippedManifest"
            Set-CopyrightInfo -Path $unzippedManifest

            Write-Output "Removing module manifest dependencies for $unzippedManifest"
            Remove-ModuleDependencies -Path (Join-Path $TempRepoPath $unzippedManifest)

            Remove-Item -Path $zipPath -Force

            Write-Output "Repackaging $dirPath"
            Update-NugetPackage -BasePath $TempRepoPath -ModuleName $moduleName -DirPath $dirPath -NugetExe $NugetExe
            Write-Output "Removing temporary folder $dirPath"
            Remove-Item -Recurse $dirPath -Force -ErrorAction Stop
        } finally {
            Pop-Location
        }
    }
}

<#
.SYNOPSIS Publish the module to PS Gallery.

.PARAMETER Path
Path to the module.

.PARAMETER ApiKey
Key used to publish.

.PARAMETER TempRepoPath
Path to the local temporary repository containing nuget.

.PARAMETER RepoLocation
Repository we are publishing too.

.PARAMETER NugetExe
Path to nuget executable.

#>
function Publish-PowershellModule {
    [CmdletBinding()]
    param(
        [string]$Path,
        [string]$ApiKey,
        [string]$TempRepoPath,
        [string]$RepoLocation,
        [string]$NugetExe
    )

    PROCESS {
        $moduleName = (Get-Item -Path $Path).Name
        $moduleManifest = $moduleName + ".psd1"
        $moduleSourcePath = Join-Path -Path $Path -ChildPath $moduleManifest
        $manifest = Test-ModuleManifest -Path $moduleSourcePath
        $nupkgPath = Join-Path -Path $TempRepoPath -ChildPath ($moduleName + "." + $manifest.Version.ToString() + ".nupkg")
        if (!(Test-Path -Path $nupkgPath)) {
            throw "Module at $nupkgPath in $TempRepoPath does not exist"
        }

        Write-Output "Pushing package $moduleName to nuget source $RepoLocation"
        &$NugetExe push $nupkgPath $ApiKey -s $RepoLocation
        Write-Output "Pushed package $moduleName to nuget source $RepoLocation"
    }
}

<#
.SYNOPSIS Add given modules to local repository.

.PARAMETER ModulePaths
List of paths to modules.

.PARAMETER TempRepo
Name of local temporary repository.

.PARAMETER TempRepoPath
path to local temporary repository.

.PARAMETER NugetExe
Path to nuget executable.

#>
function Add-Modules {
    [CmdletBinding()]
    param(
        [String[]]$ModulePaths,

        [ValidateNotNullOrEmpty()]
        [String]$TempRepo,

        [ValidateNotNullOrEmpty()]
        [String]$TempRepoPath,

        [ValidateNotNullOrEmpty()]
        [String]$NugetExe
    )
    PROCESS {
        foreach ($modulePath in $ModulePaths) {
            Write-Output $modulePath
            $module = Get-Item -Path $modulePath
            Write-Output "Updating $module module from $modulePath"
            Add-Module -Path $modulePath -TempRepo $TempRepo -TempRepoPath $TempRepoPath -NugetExe $NugetExe
            Write-Output "Updated $module module"
        }
    }
}

<#
.SYNOPSIS Get the modules to publish.

.PARAMETER BuildConfig
The build configuration, either Release or Debug

.PARAMETER Scope
The module scope, either All, Storage, or Stack.

.PARAMETER PublishToLocal
$true if publishing locally only, $false otherwise

.PARAMETER Profile
Either latest or stack

.PARAMETER IsNetCore
If the modules are built using Net Core.

#>
function Get-AllModules {
    [CmdletBinding()]
    param(
        [ValidateNotNullOrEmpty()]
        [String]$BuildConfig,

        [ValidateNotNullOrEmpty()]
        [String]$Scope,

        [switch]$PublishLocal,

        [ValidateNotNullOrEmpty()]
        [String]$Profile,

        [switch]$IsNetCore
    )

    Write-Host "Getting client modules"
    $clientModules = Get-ClientModules -BuildConfig $BuildConfig -Scope $Scope -PublishLocal:$PublishLocal -Profile $Profile -IsNetCore:$isNetCore
    Write-Host " "

    Write-Host "Getting admin modules"
    $adminModules = Get-AdminModules -BuildConfig $BuildConfig -Scope $Scope -IsNetCore:$isNetCore
    Write-Host " "

    Write-Host "Getting rollup modules"
    $rollupModules = Get-RollupModules -BuildConfig $BuildConfig -Scope $Scope -IsNetCore:$isNetCore
    Write-Host " "

    return @{
        ClientModules=$clientModules;
        AdminModules=$adminModules;
        RollUpModules=$rollUpModules
    }
}

<#
.SYNOPSIS Add all modules to local repo.

.PARAMETER ModulePaths
A hash table of Modules types and paths.

.PARAMETER TempRepo
The name of the temporary repository.

.PARAMETER TempRepoPath
Path to the temporary reposityroy.

.PARAMETER NugetExe
Location of nuget executable.

#>
function Add-AllModules {
    [CmdletBinding()]
    param(
        $ModulePaths,

        [ValidateNotNullOrEmpty()]
        [String]$TempRepo,

        [ValidateNotNullOrEmpty()]
        [String]$TempRepoPath,

        [ValidateNotNullOrEmpty()]
        [String]$NugetExe
    )

    $Keys = @('ClientModules', 'AdminModules', 'RollupModules')
    Write-Output "adding modules to local repo"
    foreach($module in $Keys) {
        $modulePath = $Modules[$module]
        Write-Output "Adding $module modules to local repo"
        Add-Modules -TempRepo $TempRepo -TempRepoPath $TempRepoPath -ModulePath $modulePath -NugetExe $NugetExe
        Write-Output " "
    }
    Write-Output " "
}

<#
.SYNOPSIS Publish the nugets to PSGallery

.PARAMETER ApiKey
Key used to publish.

.PARAMETER TempRepoPath
Path to the local temporary repository.

.PARAMETER RepoLocation
Name of repository we are publishing too.

.PARAMETER NugetExe
Path to nuget executable.

.PARAMETER PublishLocal
If publishing locally we don't do anything.

#>
function Publish-AllModules {
    [CmdletBinding()]
    param(
        $ModulePaths,

        [ValidateNotNullOrEmpty()]
        [String]$ApiKey,

        [ValidateNotNullOrEmpty()]
        [String]$TempRepoPath,

        [ValidateNotNullOrEmpty()]
        [String]$RepoLocation,

        [ValidateNotNullOrEmpty()]
        [String]$NugetExe,

        [switch]$PublishLocal
    )
    if (!$PublishLocal) {
        foreach($module in $ModulePaths.Keys) {
            $paths = $Modules[$module]
            foreach ($modulePath in $paths) {
                $module = Get-Item -Path $modulePath
                Write-Host "Pushing $module module from $modulePath"
                Publish-PowershellModule -Path $modulePath -ApiKey $apiKey -TempRepoPath $TempRepoPath -RepoLocation $RepoLocation -NugetExe $NugetExe
                Write-Host "Pushed $module module"
            }
        }
    }
}


if ([string]::IsNullOrEmpty($buildConfig)) {
    Write-Verbose "Setting build configuration to 'Release'"
    $buildConfig = "Release"
}

if ([string]::IsNullOrEmpty($repositoryLocation)) {
    Write-Verbose "Setting repository location to 'https://dtlgalleryint.cloudapp.net/api/v2'"
    $repositoryLocation = "https://dtlgalleryint.cloudapp.net/api/v2"
}

if ([string]::IsNullOrEmpty($Scope)) {
    Write-Verbose "Default scope to all"
    $Scope = 'All'
}

if ([string]::IsNullOrEmpty($nugetExe)) {
    Write-Verbose "Use default nuget path"
    $nugetExe = "$PSScriptRoot\nuget.exe"
}

Write-Host "Publishing $Scope package(and its dependencies)"
Get-PackageProvider -Name NuGet -Force

$packageFolder = "$PSScriptRoot\..\src\Package"
if ($Profile -eq "Stack") {
    $packageFolder = "$PSScriptRoot\..\src\Stack"
}

$PublishLocal = test-path $repositoryLocation
[string]$tempRepoPath = "$PSScriptRoot\..\src\package"
if ($PublishLocal) {
    if ($Profile -eq "Stack") {
        $tempRepoPath = (Join-Path $repositoryLocation -ChildPath "stack")
    } else {
        $tempRepoPath = (Join-Path $repositoryLocation -ChildPath "package")

    }
}

$tempRepoName = ([System.Guid]::NewGuid()).ToString()
$repo = Get-PSRepository | Where-Object { $_.SourceLocation -eq $tempRepoPath }
if ($repo -ne $null) {
    $tempRepoName = $repo.Name
} else {
    Register-PSRepository -Name $tempRepoName -SourceLocation $tempRepoPath -PublishLocation $tempRepoPath -InstallationPolicy Trusted -PackageManagementProvider NuGet
}

$env:PSModulePath = "$env:PSModulePath;$tempRepoPath"

$Errors = $null

try {
    $modules = Get-AllModules -BuildConfig $BuildConfig -Scope $Scope -PublishLocal:$PublishLocal -Profile $Profile -IsNetCore:$IsNetCore
    Add-AllModules -ModulePaths $modules -TempRepo $tempRepoName -TempRepoPath $tempRepoPath -NugetExe $NugetExe
    Publish-AllModules -ModulePaths $modules -ApiKey $apiKey -TempRepoPath $tempRepoPath -RepoLocation $repositoryLocation -NugetExe $NugetExe -PublishLocal:$PublishLocal
} catch {
    Write-Error ($_ | Out-String)
} finally {
    Unregister-PSRepository -Name $tempRepoName
}

if($Errors -ne $null) {
    exit 1
}
exit 0
