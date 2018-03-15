---
external help file: Azs.Storage.Admin-help.xml
Module Name: Azs.Storage.Admin
online version: 
schema: 2.0.0
---

# Restore-AzsStorageAccount

## SYNOPSIS
Undelete a deleted storage account.

## SYNTAX

### StorageAccounts_Undelete (Default)
```
Restore-AzsStorageAccount [-ResourceGroupName <String>] -FarmId <String> -Name <String>
```

### InputObject_StorageAccounts_Undelete
```
Restore-AzsStorageAccount -InputObject <StorageAccount>
```

### ResourceId_StorageAccounts_Undelete
```
Restore-AzsStorageAccount -ResourceId <String>
```

## DESCRIPTION
Undelete a deleted storage account.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Restore-AzsStorageAccount -FarmId "90987d65-eb60-42ae-b735-18bcd7ff69da" -Name "83fe9ac0-f1e7-433e-b04c-c61ae0712093"
```

## PARAMETERS

### -FarmId
Farm Id.

```yaml
Type: String
Parameter Sets: StorageAccounts_Undelete
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject
The input object of type Microsoft.AzureStack.Management.Storage.Admin.Models.StorageAccount.

```yaml
Type: StorageAccount
Parameter Sets: InputObject_StorageAccounts_Undelete
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Name
Internal storage account ID, which is not visible to tenant.

```yaml
Type: String
Parameter Sets: StorageAccounts_Undelete
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
Parameter Sets: StorageAccounts_Undelete
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
Parameter Sets: ResourceId_StorageAccounts_Undelete
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

