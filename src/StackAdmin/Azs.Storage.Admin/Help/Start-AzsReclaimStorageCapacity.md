---
external help file: Azs.Storage.Admin-help.xml
Module Name: Azs.Storage.Admin
online version:
schema: 2.0.0
---

# Start-AzsReclaimStorageCapacity

## SYNOPSIS
Start garbage collection on deleted storage objects.

## SYNTAX

```
Start-AzsReclaimStorageCapacity [-ResourceGroupName <String>] -FarmName <String> [-AsJob]
```

## DESCRIPTION
Start garbage collection on deleted storage objects.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Start-AzsReclaimStorageCapacity -FarmName "44263c10-13b2-4912-9b17-85c1e43b2a30"
```

RequestId : 436f7d46-2add-46c7-b8b8-3dd27ccf5249

## PARAMETERS

### -AsJob
{{Fill AsJob Description}}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -FarmName
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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

