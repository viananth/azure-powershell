---
external help file: Azs.Storage.Admin-help.xml
Module Name: Azs.Storage.Admin
online version: 
schema: 2.0.0
---

# Get-AzsQueueServiceMetricDefinition

## SYNOPSIS
Returns a list of metric definitions for queue service.

## SYNTAX

```
Get-AzsQueueServiceMetricDefinition [-Skip <Int32>] [-ResourceGroupName <String>] -FarmId <String>
 [-Top <Int32>]
```

## DESCRIPTION
Returns a list of metric definitions for queue service.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Get-AzsQueueServiceMetricDefinition -ResourceGroupName "system.local" -FarmId f9b8e2e2-e4b4-44e0-9d92-6a848b1a5376
```

PrimaryAggregationType                                       Unit
----------------------                                       ----
Average                                                      Count
Average                                                      Count
Average                                                      Count
Total                                                        Count
Total                                                        Count
Total                                                        Count
Average                                                      CountPerSecond
Average                                                      Count
Average                                                      Count
Average                                                      Count
Average                                                      Count
Average                                                      Count

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

### -Skip
Skip the first N items as specified by the parameter value.

```yaml
Type: Int32
Parameter Sets: (All)
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
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: -1
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

### Microsoft.AzureStack.Management.Storage.Admin.Models.MetricDefinition

## NOTES

## RELATED LINKS

