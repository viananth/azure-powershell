---
external help file: Azs.Storage.Admin-help.xml
Module Name: Azs.Storage.Admin
online version: 
schema: 2.0.0
---

# Remove-AzsStorageQuota

## SYNOPSIS
Delete an existing quota

## SYNTAX

### StorageQuotas_Delete (Default)
```
Remove-AzsStorageQuota [-Location <String>] -Name <String>
```

### ResourceId_StorageQuotas_Delete
```
Remove-AzsStorageQuota -ResourceId <String>
```

### InputObject_StorageQuotas_Delete
```
Remove-AzsStorageQuota -InputObject <StorageQuota>
```

## DESCRIPTION
Delete an existing quota

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Remove-AzsStorageQuota -Location local -Name 'TestDeleteStorageQuota'
```

## PARAMETERS

### -InputObject
The input object of type Microsoft.AzureStack.Management.Storage.Admin.Models.StorageQuota.

```yaml
Type: StorageQuota
Parameter Sets: InputObject_StorageQuotas_Delete
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
Parameter Sets: StorageQuotas_Delete
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
Parameter Sets: StorageQuotas_Delete
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
Parameter Sets: ResourceId_StorageQuotas_Delete
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

