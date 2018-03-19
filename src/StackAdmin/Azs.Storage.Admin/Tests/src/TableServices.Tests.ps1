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
    Run AzureStack TableServices admin tests

.DESCRIPTION
    Run AzureStack TableServices admin tests using either mock client or our client.
	The mock client allows for recording and playback.  This allows for offline tests.

.PARAMETER RunRaw
    Run using our client creation path.

.EXAMPLE
    PS C:\> .\src\TableServices.Tests.ps1
    Describing TableServices
	  [+] TestGetTableService 1.62s
	  [+] TestListAlltableServiceMetricDefinitions 1.23s
	  [+] TestListAllTableServiceMetrics 1.68s

.NOTES
    Author: Deepa Thomas
	Copyright: Microsoft
    Date:   February 27, 2018
#>
param(
	[bool]$RunRaw = $false
)

$global:RunRaw = $RunRaw

. $PSScriptRoot\CommonModules.ps1

$global:TestName = ""

InModuleScope Azs.Storage.Admin {

	Describe "TableServices" -Tags @('TableServices', 'Azs.Storage.Admin') {

		BeforeEach  {

			. $PSScriptRoot\Common.ps1

			function ValidateTableService {
				param(
					[Parameter(Mandatory=$true)]
					$tableService
				)
				# Resource
				$tableService								| Should Not Be $null

				# Validate TableService properties
				$tableService.FrontEndCallbackThreadsCount					| Should Not Be $null
				$tableService.FrontEndCpuBasedKeepAliveThrottlingCpuMonitorIntervalInSeconds					| Should Not Be $null
				$tableService.Id							| Should Not Be $null
				$tableService.Location						| Should Not Be $null
				$tableService.Name							| Should Not Be $null
				$tableService.FrontEndCpuBasedKeepAliveThrottlingEnabled					| Should Not Be $null
				$tableService.FrontEndCpuBasedKeepAliveThrottlingPercentCpuThreshold				| Should Not Be $null
				$tableService.Type							| Should Not Be $null
				$tableService.FrontEndCpuBasedKeepAliveThrottlingPercentRequestsToThrottle						| Should Not Be $null
				$tableService.FrontEndHttpListenPort					| Should Not Be $null
				$tableService.FrontEndHttpsListenPort					| Should Not Be $null
				$tableService.FrontEndMaxMillisecondsBetweenMemorySamples					| Should Not Be $null
				$tableService.FrontEndMemoryThrottleThresholdSettings					| Should Not Be $null
				$tableService.FrontEndMemoryThrottlingEnabled							| Should Not Be $null
				$tableService.FrontEndMinThreadPoolThreads						| Should Not Be $null
				$tableService.FrontEndThreadPoolBasedKeepAliveIOCompletionThreshold							| Should Not Be $null
				$tableService.FrontEndThreadPoolBasedKeepAliveMonitorIntervalInSeconds					| Should Not Be $null
				$tableService.FrontEndThreadPoolBasedKeepAlivePercentage				| Should Not Be $null
				$tableService.FrontEndThreadPoolBasedKeepAliveWorkerThreadThreshold							| Should Not Be $null
				$tableService.FrontEndUseSlaTimeInAvailability						| Should Not Be $null
			}
		}

		It "TestGetTableService" {
			$global:TestName = 'TestGetTableService'

			$farms =  Get-AzsStorageFarm -ResourceGroupName $global:ResourceGroup
			foreach($farm in $farms) {
				$tableService = Get-AzsTableService -ResourceGroupName $global:ResourceGroup -FarmName (Select-Name $farm.Name)
				ValidatetableService -tableService $tableService
			}
		}

		It "TestListAlltableServiceMetricDefinitions" {
			$global:TestName = 'TestListAlltableServiceMetricDefinitions'

			$farms =  Get-AzsStorageFarm -ResourceGroupName $global:ResourceGroup
			foreach($farm in $farms) {
				$result = Get-AzsTableServiceMetricDefinition -ResourceGroupName $global:ResourceGroup -FarmName (Select-Name $farm.Name)
			}
		}

		It "TestListAllTableServiceMetrics" {
			$global:TestName = 'TestListAllTableServiceMetrics'

			$farms =  Get-AzsStorageFarm -ResourceGroupName $global:ResourceGroup
			foreach($farm in $farms) {
				$result = Get-AzsTableServiceMetric -ResourceGroupName $global:ResourceGroup -FarmName (Select-Name $farm.Name)
			}
		}
	}
}
