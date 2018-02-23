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
    Run AzureStack subscription admin tests.

.DESCRIPTION
    Run AzureStack subscriptions admin tests using either mock client or our client.
	The mock client allows for recording and playback.  This allows for offline tests.

.PARAMETER RunRaw
    Run using our client creation path.

.EXAMPLE
    C:\PS> .\src\Network.Tests.ps1
	Describing SubscriptionTests
	[+] TestListRegionHealths 182ms
	[+] TestGetRegionHealth 112ms
	[+] TestGetAllRegionHealths 113ms

.NOTES
    Author: Bala Ganapathy
	Copyright: Microsoft
    Date:   February 21, 2018
#>
param(
	[bool]$RunRaw = $false
)

$Global:RunRaw = $RunRaw

. $PSScriptRoot\CommonModules.ps1

InModuleScope Azs.Network.Admin {

	Describe "Subscription" -Tags @('Subscriptions', 'SubscriptionsAdmin') {

		BeforeEach  {

			. $PSScriptRoot\Common.ps1

			function ValidateSubscription {
				param(
					[Parameter(Mandatory=$true)]
					$Subscription
				)
			
				$Subscription          | Should Not Be $null

				# Resource
				$Subscription.Id       | Should Not Be $null
				$Subscription.Name     | Should Not Be $null
				$Subscription.Type     | Should Not Be $null

			}

			function AssertSubscriptionsAreSame {
				param(
					[Parameter(Mandatory=$true)]
					$Expected,
        
					[Parameter(Mandatory=$true)]
					$Found
				)
				if($Expected -eq $null) {
					$Found | Should Be $null
				} else {
					$Found                  | Should Not Be $null

					# Resource
					$Found.Id               | Should Be $Expected.Id
					$Found.Location         | Should Be $Expected.Location
					$Found.Name             | Should Be $Expected.Name
					$Found.Type             | Should Be $Expected.Type


				}
			}
		}
	
		
		It "TestListAllSubscriptions" {
			$global:TestName = 'TestListAllSubscriptions'

			$Subscriptions = Get-AzsSubscription
			$Subscriptions | Should Not Be $null
			foreach($Subscription in $Subscriptions) {
				ValidateSubscription -Subscription $Subscription
			}
	    }
	
	
		It "TestGetSubscription" {
            $global:TestName = 'TestGetSubscription'
			
			$Subscriptions = Get-AzsSubscription
			$Subscriptions | Should Not Be $null
			foreach($Subscription in $Subscriptions) {
				$retrieved = Get-AzsSubscription -SubscriptionName $Subscription.Name
				AssertSubscriptionsAreSame -Expected $Subscription -Found $retrieved
				break
			}
		}

		It "TestGetAllSubscriptions" {
			$global:TestName = 'TestGetAllSubscriptions'

			$Subscriptions = Get-AzsSubscription
			$Subscriptions | Should Not Be $null
			foreach($Subscription in $Subscriptions) {
				$retrieved = Get-AzsSubscription -SubscriptionName $Subscription.Name
				AssertSubscriptionsAreSame -Expected $Subscription -Found $retrieved
			}
		}

		It "TestCreateAndDeleteSubscription" {
			$global:TestName = 'TestCreateAndDeleteSubscription'

			$name = "microsoft.vmss.1.3.6"
			$uri = "https://github.com/Azure/AzureStack-Tools/raw/master/ComputeAdmin/microsoft.vmss.1.3.6.azpkg"
			Remove-AzsSubscription -SubscriptionName $name

			$Subscription = New-AzsSubscription -SubscriptionUri $uri
			$Subscription | Should Not Be $null

			Remove-AzsSubscription -SubscriptionName $name
		}
    }
}