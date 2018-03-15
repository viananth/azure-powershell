---
external help file: Azs.Storage.Admin-help.xml
Module Name: Azs.Storage.Admin
online version: 
schema: 2.0.0
---

# Get-AzsStorageAccount

## SYNOPSIS
Returns the requested storage account.

## SYNTAX

### StorageAccounts_Get (Default)
```
Get-AzsStorageAccount [-ResourceGroupName <String>] -FarmId <String> -Name <String>
```

### StorageAccounts_List
```
Get-AzsStorageAccount -Summary <Boolean> [-Skip <Int32>] [-ResourceGroupName <String>] -FarmId <String>
 [-Top <Int32>]
```

### InputObject_StorageAccounts_Get
```
Get-AzsStorageAccount -InputObject <StorageAccount>
```

### ResourceId_StorageAccounts_Get
```
Get-AzsStorageAccount [-ResourceId <String>]
```

## DESCRIPTION
Returns the requested storage account.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Get-AzsStorageAccount -ResourceGroupName "system.local" -FarmId f9b8e2e2-e4b4-44e0-9d92-6a848b1a5376 -Summary $false
```

AccountTy Name      Location  StatusOfP CreationT AccountSt
pe                            rimary    ime       atus
--------- ----      --------  --------- --------- ---------
Standa...
036578...
local     Available 03/05/...
Active
Standa...
091f2b...
local     Available 03/05/...
Active
Standa...
0a8951...
local     Available 03/05/...
Active

## PARAMETERS

### -FarmId
Farm Id.

```yaml
Type: String
Parameter Sets: StorageAccounts_Get, StorageAccounts_List
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
Parameter Sets: InputObject_StorageAccounts_Get
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
Parameter Sets: StorageAccounts_Get
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
Parameter Sets: StorageAccounts_Get, StorageAccounts_List
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
Parameter Sets: ResourceId_StorageAccounts_Get
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Skip
Skip the first N items as specified by the parameter value.

```yaml
Type: Int32
Parameter Sets: StorageAccounts_List
Aliases: 

Required: False
Position: Named
Default value: -1
Accept pipeline input: False
Accept wildcard characters: False
```

### -Summary
Switch for wheter summary or detailed information is returned.

```yaml
Type: Boolean
Parameter Sets: StorageAccounts_List
Aliases: 

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Top
Return the top N items as specified by the parameter value.
Applies after the -Skip parameter.

```yaml
Type: Int32
Parameter Sets: StorageAccounts_List
Aliases: 

Required: False
Position: Named
Default value: -1
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

### Microsoft.AzureStack.Management.Storage.Admin.Models.StorageAccount

## NOTES

## RELATED LINKS

