---
external help file: Azs.Compute.Admin-help.xml
Module Name: Azs.Compute.Admin
online version:
schema: 2.0.0
---

# Get-AzsComputeQuota

## SYNOPSIS
Returns quotas specifying the quota limits for compute objects.

## SYNTAX

### List (Default)
```
Get-AzsComputeQuota [-Location <String>]
```

### Get
```
Get-AzsComputeQuota -Name <String> [-Location <String>]
```

### ResourceId
```
Get-AzsComputeQuota -ResourceId <String>
```

## DESCRIPTION
Get a list of existing quotas.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Get-AzsComputeQuota -Location local

AvailabilitySet Id              Type            CoresLimit      VmScaleSetCount Name            VirtualMachineC Location
Count                                                                                           ount
--------------- --              ----            ----------      --------------- ----            --------------- --------
10              /subscriptio...
Microsoft.Co...
50              20              Default Quota   20              local
```

Get all compute quotas at the specified location.

### -------------------------- EXAMPLE 2 --------------------------
```
Get-AzsComputeQuota -Location local -Name 'Default Quota'

AvailabilitySet Id              Type            CoresLimit      VmScaleSetCount Name            VirtualMachineC Location
Count                                                                                           ount
--------------- --              ----            ----------      --------------- ----            --------------- --------
10              /subscriptio...
Microsoft.Co...
50              20              Default Quota   20              local
```

Get a specific compute quota.

## PARAMETERS

### -Location
{{Fill Location Description}}

```yaml
Type: String
Parameter Sets: List, Get
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Name of the quota.

```yaml
Type: String
Parameter Sets: Get
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
Parameter Sets: ResourceId
Aliases: id

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

### Microsoft.AzureStack.Management.Compute.Admin.Models.Quota

## NOTES

## RELATED LINKS

