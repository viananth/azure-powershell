﻿# ----------------------------------------------------------------------------------
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
    Run AzureStack Compute admin edge gateway tests.

.DESCRIPTION
    Run AzureStack Compute admin edge gateway tests using either mock client or our client.
	The mock client allows for recording and playback.  This allows for offline tests.

.PARAMETER RunRaw
    Run using our client creation path.

.EXAMPLE
    C:\PS> .\src\SubscriberUsageAggregate.Tests.ps1
    Describing SubscriberUsageAggregates
	 [+] TestListSubscriberUsageAggregates 81ms
	 [+] TestGetSubscriberUsageAggregate 73ms
	 [+] TestGetAllSubscriberUsageAggregates 66ms

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
$global:Location = "local"

InModuleScope Azs.Compute.Admin {

	Describe "Quota" -Tags @('Quota', 'Azs.Compute.Admin') {

		BeforeEach  {

			. $PSScriptRoot\Common.ps1

			function ValidateComputeQuota {
				param(
					[Parameter(Mandatory=$true)]
					$Quota
				)

				$Quota          | Should Not Be $null

				# Resource
				$Quota.Id       | Should Not Be $null
				$Quota.Name     | Should Not Be $null
				$Quota.Type     | Should Not Be $null

				# Subscriber Usage Aggregate
				$Quota.AvailabilitySetCount | Should Not Be $null
				$Quota.CoresLimit           | Should Not Be $null
				$Quota.VirtualMachineCount  | Should Not Be $null
				$Quota.VmScaleSetCount      | Should Not Be $null
			}

			function AssertSame{
				param(
					$Expected,
					$Found
				)
			}
		}


		It "TestListQuotas" {
			$global:TestName = 'TestListQuotas'
			$quotas= Get-AzsComputeQuota  -Location $global:Location
			$quotas | Should Not Be $null
			foreach($quota in $quotas) {
				ValidateComputeQuota -Quota $quota
			}
		}


		It "TestGetQuota" {
			$global:TestName = 'TestGetQuota'

			$quotas = Get-AzsComputeQuota  -Location $global:Location
			$quotas | Should Not Be $null
			foreach($quota in $quotas) {
				$result = Get-AzsComputeQuota -Location $global:Location -Name $quota.Name
				AssertSame -Expected $quota -Found $result
				break
			}
		}


		It "TestGetAllQuotas" {
			$global:TestName = 'TestGetAllQuotas'
			$quotas = Get-AzsComputeQuota  -Location $global:Location
			$quotas | Should Not Be $null
			foreach($quota in $quotas) {
				$result = Get-AzsComputeQuota -Location $global:Location -Name $quota.Name
				AssertSame -Expected $quota -Found $result
			}
		}


		It "TestCreateQuota" {
			$global:TestName = 'TestCreateQuota'

			$quotaNamePrefix = "testQuota"

			$data = @(
				@(0, 0, 0, 0, 0),
				@(0, 1, 0, 0, 1),
				@(0, 0, 1, 0, 2),
				@(0, 0, 0, 1, 3),
				@(100, 100, 100, 100, 4),
				@(1000, 1000, 1000, 1000, 5)
			)

			$data | % {
				$name = $quotaNamePrefix + $_[4]
				$quota = New-AzsComputeQuota -Location $global:Location -Name $name -AvailabilitySetCount $_[0] -CoresLimit $_[1] -VmScaleSetCount $_[2] -VirtualMachineCount $_[3]
				$result = Get-AzsComputeQuota -Location $global:Location -Name $quota.Name
				AssertSame -Expected $quota -Found $result
			}

			$data | % {
				$name = $quotaNamePrefix + $_[4]
				Get-AzsComputeQuota -Location $global:Location| Where-Object { $_.Name -eq $name} | Should not be $null
			}
			$data | % {
				$name = $quotaNamePrefix + $_[4]
				Remove-AzsComputeQuota -Location $global:Location -Name $name
			}

		}

		# Tests wth Invalid data


		It "TestCreateInvalidQuota" {
			$global:TestName = 'TestCreateInvalidQuota'

			$data = @(
				@(-1, 1, 1, 1),
				@(1, -1, 1, 1),
				@(1, 1, -1, 1),
				@(1, 1, 1, -1),
				@(-1, 0, 0, 0),
				@( 0, -1, 0, 0),
				@( 0, 0,-1, 0),
				@( 0, 0, 0,-1),
				@(-1,-1,-1,-1)
			)

			$name = "myQuota"
			$data | % {
				{
					$quota = New-AzsComputeQuota -Location $global:Location -Name $name -AvailabilitySetCount $_[0] -CoresLimit $_[1] -VmScaleSetCount $_[2] -VirtualMachineCount $_[3]
				} | Should Throw
			}
		}


		# Apparently CRP will default to a place even if it does not exist
		It "TestListInvalidLocation" -Skip {
			$global:TestName = 'TestListInvalidLocation'
			$quotas= Get-AzsComputeQuota  -Location "thisisnotarealplace"
			$quotas | Should Be $null
		}


		It "TestDeleteNonExistingQuota" {
			$global:TestName = 'TestDeleteNonExistingQuota'

			Remove-AzsComputeQuota -Location $global:Location -Name "thisdoesnotexistandifitdoesoops"
		}


		It "TestCreateQuotaOnInvalidLocation" -Skip {
			$global:TestName = 'TestCreateQuotaOnInvalidLocation'

			$quotaNamePrefix = "testQuota"
			$invalidLocation = "thislocationdoesnotexist"

			$data = @(
				@(0, 0, 0, 0, 0),
				@(0, 1, 0, 0, 1),
				@(0, 0, 1, 0, 2),
				@(0, 0, 0, 1, 3),
				@(100, 100, 100, 100, 4),
				@(1000, 1000, 1000, 1000, 5)
			)

			$data | % {
				$name = $quotaNamePrefix + $_[4]
				New-AzsComputeQuota -Location $invalidLocation -Name $name -AvailabilitySetCount $_[0] -CoresLimit $_[1] -VmScaleSetCount $_[2] -VirtualMachineCount $_[3] | Should be $null
				Get-AzsComputeQuota -Location $invalidLocation -Name $quota.Name | Should be $null

			}

			$data | % {
				$name = $quotaNamePrefix + $_[4]
				Get-AzsComputeQuota -Location | Where-Object { $_.Name -eq $name} | Should be $null
			}
		}
	}
}
