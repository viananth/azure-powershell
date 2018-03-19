---
external help file: Azs.Storage.Admin-help.xml
Module Name: Azs.Storage.Admin
online version:
schema: 2.0.0
---

# Get-AzsTableService

## SYNOPSIS
Returns the table servie.

## SYNTAX

```
Get-AzsTableService [-ResourceGroupName <String>] -FarmName <String>
```

## DESCRIPTION
Returns the table servie.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Get-AzsTableService -ResourceGroupName "system.local" -FarmName f9b8e2e2-e4b4-44e0-9d92-6a848b1a5376
```

Name              Location          Version           HealthStatus
----              --------          -------           ------------
f9b8e2e2-e4b4-...
local             1.0

## PARAMETERS

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

### Microsoft.AzureStack.Management.Storage.Admin.Models.TableService

## NOTES

## RELATED LINKS

