---
external help file: Azs.Storage.Admin-help.xml
Module Name: Azs.Storage.Admin
online version:
schema: 2.0.0
---

# Get-AzsStorageShare

## SYNOPSIS
Returns a list of storage shares.

## SYNTAX

### Shares_List (Default)
```
Get-AzsStorageShare [-ResourceGroupName <String>] -FarmName <String>
```

### Shares_Get
```
Get-AzsStorageShare [-ResourceGroupName <String>] -Name <String> -FarmName <String>
```

### ResourceId_Shares_Get
```
Get-AzsStorageShare -ResourceId <String>
```

### InputObject_Shares_Get
```
Get-AzsStorageShare -InputObject <Share>
```

## DESCRIPTION
Returns a list of storage shares.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Get-AzsStorageShare -ResourceGroupName "system.local" -FarmName f9b8e2e2-e4b4-44e0-9d92-6a848b1a5376
```

Name        Location    ShareName   FreeCapacit UsedCapacit TotalCapaci HealthStatu
									y           y           ty          s
----        --------    ---------   ----------- ----------- ----------- -----------
f9b8e2e2...
local       ||SU1Fil...
25704435...
15773314...
27281766...
Healthy

## PARAMETERS

### -FarmName
Farm Id.

```yaml
Type: String
Parameter Sets: Shares_List, Shares_Get
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject
The input object of type Microsoft.AzureStack.Management.Storage.Admin.Models.Share.

```yaml
Type: Share
Parameter Sets: InputObject_Shares_Get
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Name
Share name.

```yaml
Type: String
Parameter Sets: Shares_Get
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ResourceGroupName
Resource group name.

```yaml
Type: String
Parameter Sets: Shares_List, Shares_Get
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ResourceId
The resource id.

```yaml
Type: String
Parameter Sets: ResourceId_Shares_Get
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

### Microsoft.AzureStack.Management.Storage.Admin.Models.Share

## NOTES

## RELATED LINKS

