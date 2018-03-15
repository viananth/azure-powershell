---
external help file: Azs.Network.Admin-help.xml
Module Name: Azs.Network.Admin
online version: 
schema: 2.0.0
---

# Get-AzsNetworkQuota

## SYNOPSIS
List all quotas.

## SYNTAX

### Quotas_List (Default)
```
Get-AzsNetworkQuota [-Location <String>] [-Filter <String>]
```

### Quotas_Get
```
Get-AzsNetworkQuota -Name <String> [-Location <String>]
```

### ResourceId_Quotas_Get
```
Get-AzsNetworkQuota -ResourceId <String>
```

### InputObject_Quotas_Get
```
Get-AzsNetworkQuota -InputObject <Quota>
```

## DESCRIPTION
List all quotas.
Limit the list by passing a name or filter.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Get-AzsNetworkQuota -Name NetworkQuota1
```

MaxPublicIpsPerSubscription                        : 50
MaxVnetsPerSubscription                            : 50
MaxVirtualNetworkGatewaysPerSubscription           : 1
MaxVirtualNetworkGatewayConnectionsPerSubscription : 2
MaxLoadBalancersPerSubscription                    : 50
MaxNicsPerSubscription                             : 50
MaxSecurityGroupsPerSubscription                   : 50
MigrationPhase                                     : None
Id                                                 : /subscriptions/df5abebb-3edc-40c5-9155-b4ab239d79d3/providers/Microsoft.Network.Admin/locations/local/quotas/Networ
                                                     kQuota1
Name                                               : NetworkQuota1
Type                                               : Microsoft.Network.Admin/quotas
Location                                           : 
Tags                                               :

## PARAMETERS

### -Filter
OData filter parameter.

```yaml
Type: String
Parameter Sets: Quotas_List
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject
The input object of type Microsoft.AzureStack.Management.Network.Admin.Models.Quota.

```yaml
Type: Quota
Parameter Sets: InputObject_Quotas_Get
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Location
Location of the resource.

```yaml
Type: String
Parameter Sets: Quotas_List, Quotas_Get
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Name of the resource.

```yaml
Type: String
Parameter Sets: Quotas_Get
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ResourceId
The resource id.

```yaml
Type: String
Parameter Sets: ResourceId_Quotas_Get
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

### Microsoft.AzureStack.Management.Network.Admin.Models.Quota

## NOTES

## RELATED LINKS

