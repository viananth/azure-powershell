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

    # Common functions
    function ValidateBaseResources {
        param(
            [Parameter(Mandatory = $true)]
            $Resource
        )
	
        $Resource          | Should Not Be $null
        $Resource.Id       | Should Not Be $null
        $Resource.Name       | Should Not Be $null
    }

    function ValidateBaseResourceTenant {
        param(
            [Parameter(Mandatory = $true)]
            $Tenant
        )

        $Tenant                  	| Should Not Be $null
        $Tenant.SubscriptionId   | Should Not Be $null
        $Tenant.TenantResourceUri   | Should Not Be $null
    }

    function CheckBaseResourcesAreSame {
        param(
            $expected,
            $found
        )

        $expected.Id -eq $found.Id | Should Be $true
        $expected.Location -eq $found.Location | Should Be $true
        $expected.Name -eq $found.Name | Should Be $true
        $expected.Type -eq $found.Type | Should Be $true
    }
    Describe "NetworkTests" {

        BeforeEach {

            . $PSScriptRoot\Common.ps1

            function AssertAdminOverviewResourceHealth {
                param(
                    [Parameter(Mandatory = $true)]
                    $Health
                )
			
                $Health          | Should Not Be $null
                $Health.ErrorResourceCount       | Should Not Be $null
                $Health.HealthUnknownCount       | Should Not Be $null
                $Health.HealthyResourceCount     | Should Not Be $null
            }

            function AssertAdminOverviewResourceUsage {
                param(
                    [Parameter(Mandatory = $true)]
                    $Usage
                )

                $Usage                  	| Should Not Be $null
                $Usage.InUseResourceCount   | Should Not Be $null
                $Usage.TotalResourceCount   | Should Not Be $null
            }
        }
	
		
        It "TestGetAdminOverview" {
            $global:TestName = 'TestGetAdminOverview'

            $Overview = Get-AzsResourceProviderState
            $Overview | Should Not Be $null
			
            AssertAdminOverviewResourceHealth($Overview.LoadBalancerMuxHealth);
            AssertAdminOverviewResourceHealth($Overview.VirtualNetworkHealth);
            AssertAdminOverviewResourceHealth($Overview.VirtualGatewayHealth);

            AssertAdminOverviewResourceUsage($Overview.MacAddressUsage);
            AssertAdminOverviewResourceUsage($Overview.PublicIpAddressUsage);
            AssertAdminOverviewResourceUsage($Overview.BackendIpUsage);
        }
    }

    Describe "LoadBalancerTests" {
        BeforeEach {

            . $PSScriptRoot\Common.ps1

        }

        It "TestGetAllLoadBalancers" {
            $global:TestName = 'TestGetAllLoadBalancers'
			
            $Balancers = Get-AzsLoadBalancer
            # This test should be using the SessionRecord which has an existing LoadBalancer created
            if ($null -ne $Balancers) {
                foreach ($Balancer in $Balancers) {
                    ValidateBaseResources($Balancer)
                    ValidateBaseResourceTenant($Balancer)
                    $Balancer.PublicIpAddresses | Should Not Be $null
                    foreach ($IpAddress in $Balancer.PublicIpAddresses) {
                        $IpAddress | Should Not Be $null
                    }
                }
            }
        }
    }

    Describe "PublicIpAddressesTests" {
        BeforeEach {

            . $PSScriptRoot\Common.ps1

        }
        It "TestGetAllPublicIpAddresses" {
            $global:TestName = 'TestGetAllPublicIpAddresses'

            $addresses = Get-AzsPublicIPAddress

            # This test should be using the SessionRecord which has an existing PublicIPAddress created
            if ($null -ne $addresses) {
                foreach ($address in $addresses) {
                    ValidateBaseResources($address)
                    ValidateBaseResourceTenant($address)
                    $address.IpAddress | Should Not Be $null
                    $address.IpPool | Should Not Be $null
                }
            }
        }
        <#
		It "TestGetAllPublicIpAddressesOData" {
			$global:TestName = 'TestGetAllPublicIpAddressesOData'
			[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.Rest.Azure.OData.ODataQuery")
			$oDataQuery = New-Object -TypeName [Microsoft.Rest.Azure.OData.ODataQuery] -ArgumentList PublicIPAddress
			$oDataQuery.Top = 10
			$addresses = Get-AzsPublicIPAddress -Filter $oDataQuery
			# This test should be using the SessionRecord which has an existing PublicIPAddress created
			if ($null -ne $addresses) {
				foreach($address in $addresses) {
					ValidateBaseResources($address)
					ValidateBaseResourceTenant($address)
					$address.IpAddress | Should Not Be $null
					$address.IpPool | Should Not Be $null
				}
			} #>
    } 

    Describe "QuotasTests" {
        BeforeEach {
	
            . $PSScriptRoot\Common.ps1
        }

        function CreateTestQuota {
            $quota = New-Object -TypeName psobject
            $quota | Add-Member -MemberType NoteProperty -Name MaxPublicIpsPerSubscription -Value 32
            $quota | Add-Member -MemberType NoteProperty -Name MaxVnetsPerSubscription -Value 32
            $quota | Add-Member -MemberType NoteProperty -Name MaxVirtualNetworkGatewaysPerSubscription -Value 32
            $quota | Add-Member -MemberType NoteProperty -Name MaxVirtualNetworkGatewayConnectionsPerSubscription -Value 32
            $quota | Add-Member -MemberType NoteProperty -Name MaxLoadBalancersPerSubscription -Value 32
            $quota | Add-Member -MemberType NoteProperty -Name MaxNicsPerSubscription -Value 4
            $quota | Add-Member -MemberType NoteProperty -Name MaxSecurityGroupsPerSubscription -Value 2
            return $quota
        }

        function DeleteQuota {
            param(
                [string] $location,
                [string] $quotaName
            )

            Remove-AzsQuota -Name $quotaName -Location $location
            Start-Sleep -Seconds 5
        }

        function AssertQuotasAreSame {
            param(
                $expected,
                $found
            )
        
            if ($null -eq $expected) {
                $found | Should Be $null
            }
            else {
                CheckBaseResourcesAreSame -expected $expected -found $found

                expected.MaxLoadBalancersPerSubscription -eq found.MaxLoadBalancersPerSubscription | Should Be $true
                expected.MaxNicsPerSubscription -eq found.MaxNicsPerSubscription | Should Be $true
                expected.MaxPublicIpsPerSubscription -eq found.MaxPublicIpsPerSubscription | Should Be $true
                expected.MaxSecurityGroupsPerSubscription-eq found.MaxSecurityGroupsPerSubscription | Should Be $true
                expected.MaxVirtualNetworkGatewayConnectionsPerSubscription -eq found.MaxVirtualNetworkGatewayConnectionsPerSubscription | Should Be $true
                expected.MaxVirtualNetworkGatewaysPerSubscription -eq found.MaxVirtualNetworkGatewaysPerSubscription | Should Be $true
                expected.MaxVnetsPerSubscription -eq found.MaxVnetsPerSubscription | Should Be $true
                expected.MigrationPhase -eq found.MigrationPhase | Should Be $true
            }
        }
		
        It "TestPutAndDeleteQuota" {
            $global:TestName = 'TestPutAndDeleteQuota'
			$location = "local"
            $quotaName = "TestQuotaForRemoval"
            $newQuota = CreateTestQuota
            $retrieved = Get-AzsQuota  -Location $location -Name $quotaName
            if ($null -ne $retrieved) {
                DeleteQuota -quotaName $quotaName -Location $location
            }

            $quota = New-AzsQuota -Quota $newQuota -Name $quotaName -Location $location
            $created = Get-AzsQuota -Name $quotaName -Location $location
            AssertQuotasAreSame -expected $quota -found $created

            # Delete Quota
            DeleteQuota -quotaName $quotaName -Location $location

            $deleted = Get-AzsQuota -Name $quotaName -Location $location
            $deleted | Should be $null
		}
		
        It "TestPutAndUpdateQuota" {
            $global:TestName = 'TestPutAndUpdateQuota'
			$location = "local"
            $quotaName = "TestQuotaForUpdate"
            $newQuota = CreateTestQuota
            $retrieved = Get-AzsQuota  -Location $location -Name $quotaName
            if ($null -ne $retrieved) {
                DeleteQuota -quotaName $quotaName -Location $location
            }

            $quota = New-AzsQuota -Quota $newQuota -Name $quotaName -Location $location
            $created = Get-AzsQuota -Name $quotaName -Location $location
            AssertQuotasAreSame -expected $quota -found $created

            # Update a field
            $created.MaxNicsPerSubscription = 8

            # Post update
            $updatedQuota = Set-AzsQuota -Quota $created -Name $quotaName -Location $location
            $getUpdatedQuota = Get-AzsQuota -Name $quotaName -Location $location
            AssertQuotasAreSame -expected $updatedQuota -found $getUpdatedQuota

            # Delete Quota
            DeleteQuota -quotaName $quotaName -Location $location

            $deleted = Get-AzsQuota -Name $quotaName -Location $location
            $deleted | Should be $null
        }

	}
	
	Describe "VirtualNetworksTests" {
		BeforeEach {
	
            . $PSScriptRoot\Common.ps1
		}
		
		function ValidateConfigurationState {
			param(
				$state
			)

			$state | Should Not Be $null
			$state.Status | Should Not Be $null
			$state.LastUpdatedTime | Should Not Be $null
			$state.VirtualNetworkInterfaceErrors | Should Not Be $null
			$state.HostErrors | Should Not Be $null
		}

		It "TestGetAllVirtualNetworks" {
			$global:TestName = "TestGetAllVirtualNetworks"
			$networks = Get-AzsVirtualNetwork
		}

		It "TestGetAllVirtualNetworksOData" {
			$global:TestName = "TestGetAllVirtualNetworksOData"
			$networks = Get-AzsVirtualNetwork
		}
		
	}
}