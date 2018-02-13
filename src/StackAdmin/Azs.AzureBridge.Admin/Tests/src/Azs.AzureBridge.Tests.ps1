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
    Author: Jeffrey Robinson
	Copyright: Microsoft
    Date:   August 24, 2017
#>
param(
	[bool]$RunRaw = $false
)

$global:RunRaw = $RunRaw

. $PSScriptRoot\CommonModules.ps1

$global:TestName = ""

InModuleScope Azs.AzureBridge.Admin {

	Describe "Get-AzsAzureBridgeActivation" -Tags @('AzureBridgeActivation', 'Azs.AzureBridge.Admin') {
	
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

			function Floor-DateTime {
				param(
					[System.DateTime]$DateTime
				)

				$ts = [System.TimeSpan]::FromDays(1)
				$dto = New-Object -TypeName System.DateTimeOffset -ArgumentList $DateTime
				$diff = $dto.UtcTicks - ($dto.UtcTicks % $ts.Ticks)
				$tmp = New-Object -TypeName System.DateTime -ArgumentList $diff
				$tmp.DateTime
			}
		}

		$ActivationName = "Default"
		$ResourceGroupName = "AzureStack-Activation"
		$ProductName = "Canonical.UbuntuServer1710-ARM.1.0.6"
		
		Context "AzsAzureBridgeActivation" {
			It "TestListAzsAzureBridgeActivation" {
				$Activations = Get-AzsAzureBridgeActivation -ResourceGroup $ResourceGroupName -EA stop

				Foreach ($Activation in $Activations)
				{
					ValidateActivationInfo -Activation $Activation
				}
			}

			It "TestGetAzsAzureBridgeActivationByName" {
				$Activation = Get-AzsAzureBridgeActivation -Name $ActivationName -ResourceGroup $ResourceGroupName -EA stop
				ValidateActivationInfo -Activation $Activation
			}
		}

		Context "AzsAzureBridgeProduct" {

			It "TestListAzsAzureBridgeProduct" {
				$Products = Get-AzsAzureBridgeProduct -ActivationName $ActivationName -ResourceGroup $ResourceGroupName -EA stop
				$Products | Should Not Be $null
			}

			It "TestGetAzsAzureBridgeProductByName" {
				$Product = Get-AzsAzureBridgeProduct -ActivationName $ActivationName -ResourceGroup $ResourceGroupName -Name $ProductName -EA stop
				$Product | Should Not Be $null
			}
			
		}

		Context "AzsAzureBridgeDownloadProduct" {
			It "TestReceiveAzsAzureBridgeProduct" {
				$DownloadedProduct = Invoke-AzsAzureBridgeProductDownload -ActivationName $ActivationName -ProductName $ProductName -ResourceGroup $ResourceGroupName
				
			}
		}

	}
}