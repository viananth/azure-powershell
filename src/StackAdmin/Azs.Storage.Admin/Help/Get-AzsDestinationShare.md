---
external help file: Azs.Storage.Admin-help.xml
Module Name: Azs.Storage.Admin
online version: 
schema: 2.0.0
---

# Get-AzsDestinationShare

## SYNOPSIS
Returns a list of destination shares that the system considers as best candidates for migration.

## SYNTAX

```
Get-AzsDestinationShare [-ResourceGroupName <String>] -ShareName <String> -FarmId <String>
```

## DESCRIPTION
Returns a list of destination shares that the system considers as best candidates for migration.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Get-AzsDestinationShare -ResourceGroupName "system.local" -FarmId f9b8e2e2-e4b4-44e0-9d92-6a848b1a5376 -ShareName "||SU1FileServer.azurestack.local|SU1_ObjStore"
```

## PARAMETERS

### -FarmId
Farm Id.

```yaml
Type: String
Parameter Sets: (All)
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
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ShareName
Name of the share which holds containers to be migrated.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

