---
external help file: Azs.Storage.Admin-help.xml
Module Name: Azs.Storage.Admin
online version: 
schema: 2.0.0
---

# Get-AzsReclaimStorageCapacityStatus

## SYNOPSIS
Returns the state of the garbage collection job.

## SYNTAX

```
Get-AzsReclaimStorageCapacityStatus -OperationId <String> [-ResourceGroupName <String>] -FarmId <String>
```

## DESCRIPTION
Returns the state of the garbage collection job.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Get-AzsReclaimStorageCapacityStatus -FarmId "6ddbfe6e-8781-4a3d-b370-4a8b20a494d8" -OperationId "92360f29-cd21-429d-a20b-9b11ab5902a0"
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

### -OperationId
Operation Id.

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

