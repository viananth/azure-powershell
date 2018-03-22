---
external help file: Azs.Storage.Admin-help.xml
Module Name: Azs.Storage.Admin
online version:
schema: 2.0.0
---

# Set-AzsStorageQuota

## SYNOPSIS
Create or update an existing storage quota.

## SYNTAX

### StorageQuotas_CreateOrUpdate (Default)
```
Set-AzsStorageQuota [-CapacityInGb <Int32>] [-NumberOfStorageAccounts <Int32>] [-Location <String>]
 -QuotaName <String> [<CommonParameters>]
```

### ResourceId_StorageQuotas_CreateOrUpdate
```
Set-AzsStorageQuota [-CapacityInGb <Int32>] [-NumberOfStorageAccounts <Int32>] -ResourceId <String>
 [<CommonParameters>]
```

### InputObject_StorageQuotas_CreateOrUpdate
```
Set-AzsStorageQuota [-CapacityInGb <Int32>] [-NumberOfStorageAccounts <Int32>] -InputObject <StorageQuota>
 [<CommonParameters>]
```

## DESCRIPTION
Create or update an existing storage quota.

## EXAMPLES

### EXAMPLE 1
```
Set-AzsStorageQuota -CapacityInGb 123 -NumberOfStorageAccounts 10 -Location local -Name 'TestUpdateStorageQuota'
```

Name       Location   CapacityInGb	NumberOfStorageAccounts
	----       --------   ----------	----------
	local/T...
local      123			10

## PARAMETERS

### -CapacityInGb
Maxium capacity (GB).

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
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

### -NumberOfStorageAccounts
Total number of storage accounts.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -QuotaName
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Microsoft.AzureStack.Management.Storage.Admin.Models.StorageQuota

## NOTES

## RELATED LINKS
