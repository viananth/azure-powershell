#
# Module manifest for module 'PSGet_AzureRM'
#
# Generated by: Microsoft Corporation
#
# Generated on: 2/26/2018
#

@{

# Script module or binary module file associated with this manifest.
RootModule = 'AzureRM.psm1'

# Version number of this module.
ModuleVersion = '1.2.11'

# Supported PSEditions
# CompatiblePSEditions = @()

# ID used to uniquely identify this module
GUID = 'b433e830-b479-4f7f-9c80-9cc6c28e1b51'

# Author of this module
Author = 'Microsoft Corporation'

# Company or vendor of this module
CompanyName = 'Microsoft Corporation'

# Copyright statement for this module
Copyright = 'Microsoft Corporation. All rights reserved.'

# Description of the functionality provided by this module
Description = 'Azure Resource Manager Module'

# Minimum version of the Windows PowerShell engine required by this module
PowerShellVersion = '3.0'

# Name of the Windows PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the Windows PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
DotNetFrameworkVersion = '4.0'

# Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
CLRVersion = '4.0'

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
RequiredModules = @(@{ModuleName = 'AzureRM.Profile'; RequiredVersion = '4.2.0'; }, 
               @{ModuleName = 'Azure.Storage'; RequiredVersion = '1.0.5.4'; }, 
               @{ModuleName = 'AzureRM.Compute'; RequiredVersion = '1.2.3.4'; }, 
               @{ModuleName = 'AzureRM.Dns'; RequiredVersion = '4.0.1'; }, 
               @{ModuleName = 'AzureRM.KeyVault'; RequiredVersion = '4.1.0'; }, 
               @{ModuleName = 'AzureRM.Network'; RequiredVersion = '1.0.5.4'; }, 
               @{ModuleName = 'AzureRM.Resources'; RequiredVersion = '5.2.0'; }, 
               @{ModuleName = 'AzureRM.Storage'; RequiredVersion = '1.0.5.4'; }, 
               @{ModuleName = 'AzureRM.Tags'; RequiredVersion = '4.0.0'; }, 
               @{ModuleName = 'AzureRM.UsageAggregates'; RequiredVersion = '4.0.0'; })

# Assemblies that must be loaded prior to importing this module
# RequiredAssemblies = @()

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
# ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
# FormatsToProcess = @()

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
# NestedModules = @()

# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
FunctionsToExport = @()

# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
CmdletsToExport = @()

# Variables to export from this module
# VariablesToExport = @()

# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
AliasesToExport = @()

# DSC resources to export from this module
# DscResourcesToExport = @()

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
# FileList = @()

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        # Tags = @()

        # A URL to the license for this module.
        LicenseUri = 'https://aka.ms/azps-license'

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/Azure/azure-powershell'

        # A URL to an icon representing this module.
        # IconUri = ''

        # ReleaseNotes of this module
        ReleaseNotes = '## 2017.10.12 - Version 1.2.11
        * The release 1.2.11 comes with a list of breaking changes. To upgrade from the 1.2.10 version, we have created a migration guide at https://aka.ms/azSpowershellmigration
        * Profile
            * Context persistence has been enabled, refer to the link for the details https://docs.microsoft.com/en-us/powershell/azure/context-persistence
            * Add-AzureRmAccount - EnvironmentName parameter has been removed and replaced with Environment
            * Select-AzureRmContext has been renamed to Import-AzureRmContext
            * Save-AzureRmProfile has been renamed to Save-AzureRmContext
            * -Force Parameter has been deprecated from Remove-AzureRmEnvironment
            * Refer to the migration guide https://aka.ms/azSpowershellmigration for the object model changes
        * Compute
            * Tags parameter has been changed to Tag and the type was changed from HashTable[] to HashTable for the cmdlets New-AzureRmVM and Update-AzureRmVM
        * Dns
            * Tags parameter has been changed to Tag and the type was changed from HashTable[] to HashTable for the cmdlets New-AzureRmDnsZone and Set-AzureRmDnsZone
        * KeyVault
            * Tags parameter has been changed to Tag and the type was changed from HashTable[] to HashTable for the cmdlets New-AzureRmDnsZone and Set-AzureRmDnsZone
        * Network
            * Tags parameter has been changed to Tag and the type was changed from HashTable[] to HashTable for the following cmdlets
                  - New-AzureRmApplicationGateway
                  - New-AzureRmExpressRouteCircuit
                  - New-AzureRmLoadBalancer
                  - New-AzureRmLocalNetworkGateway
                  - New-AzureRmNetworkInterface
                  - New-AzureRmNetworkSecurityGroup
                  - New-AzureRmPublicIpAddress
                  - New-AzureRmRouteTable
                  - New-AzureRmVirtualNetwork
                  - New-AzureRmVirtualNetworkGateway
                  - New-AzureRmVirtualNetworkGatewayConnection
                  - New-AzureRmVirtualNetworkPeering
        * Resources
            * -Force parmeter has been removed from the following cmdlets
                  - Register-AzureRmProviderFeature
                  - Register-AzureRmResourceProvider
                  - Remove-AzureRmADServicePrincipal
                  - Remove-AzureRmPolicyAssignment
                  - Remove-AzureRmResourceGroupDeployment
                  - Remove-AzureRmRoleAssignment
                  - Stop-AzureRmResourceGroupDeployment
                  - Unregister-AzureRmResourceProvider
        * Tag
            * -Force parmeter has been removed from the cmdlet Remove-AzureRmTag'

        # External dependent modules of this module
        # ExternalModuleDependencies = ''

    } # End of PSData hashtable
    
 } # End of PrivateData hashtable

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}

