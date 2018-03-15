---
external help file: Azs.Storage.Admin-help.xml
Module Name: Azs.Storage.Admin
online version: 
schema: 2.0.0
---

# Get-AzsStorageQuota

## SYNOPSIS
Returns a list of storage quotas at the given location.

## SYNTAX

### StorageQuotas_List (Default)
```
Get-AzsStorageQuota [-Skip <Int32>] [-Location <String>] [-Top <Int32>]
```

### ResourceId_StorageQuotas_Get
```
Get-AzsStorageQuota -ResourceId <String>
```

### StorageQuotas_Get
```
Get-AzsStorageQuota [-Location <String>] -Name <String>
```

### InputObject_StorageQuotas_Get
```
Get-AzsStorageQuota -InputObject <StorageQuota>
```

## DESCRIPTION
Returns a list of storage quotas at the given location.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Get-AzsStorageQuota -Location local
```

Name       Location   CapacityIn NumberOfSt
					  Gb         orageAccou
								 nts
----       --------   ---------- ----------
local/D...
local      2048       20
local/T...
local      50         100

## PARAMETERS

### -InputObject
The input object of type Microsoft.AzureStack.Management.Storage.Admin.Models.StorageQuota.

```yaml
Type: StorageQuota
Parameter Sets: InputObject_StorageQuotas_Get
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Location
Resource location.

```yaml
Type: String
Parameter Sets: StorageQuotas_List, StorageQuotas_Get
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
The name of the storage quota.

```yaml
Type: String
Parameter Sets: StorageQuotas_Get
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
Parameter Sets: ResourceId_StorageQuotas_Get
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Skip
Skip the first N items as specified by the parameter value.

```yaml
Type: Int32
Parameter Sets: StorageQuotas_List
Aliases: 

Required: False
Position: Named
Default value: -1
Accept pipeline input: False
Accept wildcard characters: False
```

### -Top
Return the top N items as specified by the parameter value.
Applies after the -Skip parameter.

```yaml
Type: Int32
Parameter Sets: StorageQuotas_List
Aliases: 

Required: False
Position: Named
Default value: -1
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

### Microsoft.AzureStack.Management.Storage.Admin.Models.StorageQuota

## NOTES

## RELATED LINKS

