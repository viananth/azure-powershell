---
external help file: Azs.Storage.Admin-help.xml
Module Name: Azs.Storage.Admin
online version: 
schema: 2.0.0
---

# New-AzsStorageQuota

## SYNOPSIS
Create or update an existing storage quota.

## SYNTAX

### StorageQuotas_CreateOrUpdate (Default)
```
New-AzsStorageQuota -Name <String> [-CapacityInGb <Int32>] [-NumberOfStorageAccounts <Int32>]
 [-Location <String>]
```

### ResourceId_StorageQuotas_CreateOrUpdate
```
New-AzsStorageQuota [-CapacityInGb <Int32>] [-NumberOfStorageAccounts <Int32>] -ResourceId <String>
```

### InputObject_StorageQuotas_CreateOrUpdate
```
New-AzsStorageQuota [-CapacityInGb <Int32>] [-NumberOfStorageAccounts <Int32>] -InputObject <StorageQuota>
```

## DESCRIPTION
Create or update an existing storage quota.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
New-AzsStorageQuota -CapacityInGb 1000 -NumberOfStorageAccounts 100 -Location local -Name 'TestCreateStorageQuota'
```

Name       Location   CapacityInGb	NumberOfStorageAccounts
----       --------   ----------	----------
local/T...
local      1000			100

## PARAMETERS

### -CapacityInGb
Maxium capacity (GB).

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 500
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject
The input object of type Microsoft.AzureStack.Management.Storage.Admin.Models.StorageQuota.

```yaml
Type: StorageQuota
Parameter Sets: InputObject_StorageQuotas_CreateOrUpdate
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
Parameter Sets: StorageQuotas_CreateOrUpdate
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
Parameter Sets: StorageQuotas_CreateOrUpdate
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NumberOfStorageAccounts
Total number of storage accounts.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 20
Accept pipeline input: False
Accept wildcard characters: False
```

### -ResourceId
The resource id.

```yaml
Type: String
Parameter Sets: ResourceId_StorageQuotas_CreateOrUpdate
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

### Microsoft.AzureStack.Management.Storage.Admin.Models.StorageQuota

## NOTES

## RELATED LINKS

