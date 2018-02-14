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

<#
.SYNOPSIS
    Run AzureStack AzureBridge admin edge gateway tests.

.DESCRIPTION
    Run AzureStack AzureBridge admin edge gateway tests using either mock client or our client.
	The mock client allows for recording and playback.  This allows for offline tests.

.PARAMETER RunRaw
    Run using our client creation path.

.EXAMPLE
    C:\PS> .\src\Activation.Tests.ps1
    Describing Activations
	 [+] TestListActivations 81ms
	 [+] TestGetActivation 73ms
	 [+] TestGetAllActivations 66ms

.NOTES
#>
param(
	[bool]$RunRaw = $false
)

$global:RunRaw = $RunRaw

. $PSScriptRoot\CommonModules.ps1

$global:TestName = ""

InModuleScope Azs.AzureBridge.Admin {

	$ActivationName = "Default"
	$ResourceGroupName = "AzureStack-Activation"
	$ProductName1 = "Canonical.UbuntuServer1710-ARM.1.0.6"
	$ProductName2 = "microsoft.docker-arm.1.1.0"

	Describe "AzsAzureBridgeActivation" -Tags @('AzureBridgeActivation', 'Azs.AzureBridge.Admin') {
		BeforeEach  {
			. $PSScriptRoot\Common.ps1

			function ValidateActivationInfo {
				param(
					[Parameter(Mandatory=$true)]
					$Activation
				)

				$Activation          | Should Not Be $null

				# Resource
				$Activation.Id       | Should Not Be $null
				$Activation.Name     | Should Not Be $null
				$Activation.Type     | Should Not Be $null
				
				$Activation.ProvisioningState    | Should Not Be $null
				$Activation.Expiration         | Should Not Be $null
				$Activation.MarketplaceSyndicationEnabled        | Should Not Be $null
				$Activation.AzureRegistrationResourceIdentifier  | Should Not Be $null
				$Activation.Location    | Should Not Be $null
				$Activation.DisplayName  | Should Not Be $null
			
			}
		}
		
		Context "Get-AzsAzureBridgeActivation" {
			It "TestListAzsAzureBridgeActivation" {
				$Activations = Get-AzsAzureBridgeActivation -ResourceGroup $ResourceGroupName 

				Foreach ($Activation in $Activations)
				{
					ValidateActivationInfo -Activation $Activation
				}
			}

			It "TestGetAzsAzureBridgeActivationByName" {
				$Activation = Get-AzsAzureBridgeActivation -Name $ActivationName -ResourceGroup $ResourceGroupName 
				ValidateActivationInfo -Activation $Activation
			}
		}
	}

	Describe "AzsAzureBridgeProduct" {
		BeforeEach  {

			. $PSScriptRoot\Common.ps1

			function ValidateProductInfo {
				param(
					[Parameter(Mandatory=$true)]
					$Product
				)

				$Product          | Should Not Be $null

				# Resource
				$Product.Id       | Should Not Be $null
				$Product.Name     | Should Not Be $null
				$Product.Type     | Should Not Be $null
				
				$Product.GalleryItemIdentity    | Should Not Be $null
				$Product.ProductKind         | Should Not Be $null
				$Product.ProductProperties        | Should Not Be $null
				$Product.Description  | Should Not Be $null
				$Product.DisplayName  | Should Not Be $null
			
			}
		}

		Context "Get-AzsAzureBridgeProduct" {

			It "TestListAzsAzureBridgeProduct" {
				$Products = Get-AzsAzureBridgeProduct -ActivationName $ActivationName -ResourceGroup $ResourceGroupName 
				foreach ($Product in $Products) {
					ValidateProductInfo $Product
				}
			}

			It "TestGetAzsAzureBridgeProductByName" {
				$Product = Get-AzsAzureBridgeProduct -ActivationName $ActivationName -ResourceGroup $ResourceGroupName -Name $ProductName1 
				ValidateProductInfo $Product
			}
			
		}
	
		Context "Invoke-AzsAzureBridgeProductDownload" {
			# Mock Invoke-AzsAzureBridgeProductDownload -verifiable { }
			It "TestDownloadAzsAzureBridgeProduct" {
				$DownloadedProduct = Invoke-AzsAzureBridgeProductDownload -ActivationName $ActivationName -Name $ProductName1 -ResourceGroup $ResourceGroupName 
				ValidateProductInfo $DownloadedProduct
			}

			It "TestDownloadAzsAzureBridgeProductPipeline" {
				$DownloadedProduct = (Get-AzsAzureBridgeProduct -ActivationName $ActivationName -Name $ProductName2 -ResourceGroup $ResourceGroupName)  | Invoke-AzsAzureBridgeProductDownload
				ValidateProductInfo $DownloadedProduct
			}
		}

		Context "Get-AzsAzureBridgeDownloadedProduct" {
			It "TestGetAzsAzureBridgeDownloadedProduct" {
				$DownloadedProducts = (Get-AzsAzureBridgeDownloadedProduct -ActivationName $ActivationName -ResourceGroup $ResourceGroupName  )
				foreach ($DownloadedProduct in $DownloadedProducts)
				{
					ValidateProductInfo $DownloadedProduct
				}
			}

			It "TestGetAzsAzureBridgeDownloadedProductByProductName" {
				$DownloadedProduct = (Get-AzsAzureBridgeDownloadedProduct -ActivationName $ActivationName -Name $ProductName1 -ResourceGroup $ResourceGroupName  )
				ValidateProductInfo $DownloadedProduct
			}
		}

		Context "Remove-AzsAzureBridgeDownloadedProduct" {
			It "TestRemoveAzsAzureBridgeDownloadedProduct" {
				Remove-AzsAzureBridgeDownloadedProduct -ActivationName $ActivationName -ResourceGroup $ResourceGroupName -Name $ProductName1 -Force 
				Get-AzsAzureBridgeDownloadedProduct -ActivationName $ActivationName -ResourceGroup $ResourceGroupName -Name $ProductName1 -Force  | Should Be $null
			}

			It "TestRemoveAzsAzureBridgeDownloadedProductPipeline" {
				(Get-AzsAzureBridgeDownloadedProduct -ActivationName $ActivationName -Name $ProductName2 -ResourceGroup $ResourceGroupName ) | Remove-AzsAzureBridgeDownloadedProduct  -Force
				Get-AzsAzureBridgeDownloadedProduct -ActivationName $ActivationName -ResourceGroup $ResourceGroupName -Name $ProductName2 -Force  | Should Be $null
			}
		}

	}
}