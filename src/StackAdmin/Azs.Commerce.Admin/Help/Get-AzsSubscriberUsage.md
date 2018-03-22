---
external help file: Azs.Commerce.Admin-help.xml
Module Name: Azs.Commerce.Admin
online version:
schema: 2.0.0
---

# Get-AzsSubscriberUsage

## SYNOPSIS
Gets a collection of SubscriberUsageAggregates, which are UsageAggregates from users.

## SYNTAX

```
Get-AzsSubscriberUsage [-SubscriberId <String>] -ReportedStartTime <DateTime>
 [-AggregationGranularity <String>] [-Skip <Int32>] -ReportedEndTime <DateTime> [-ContinuationToken <String>]
 [-Top <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Gets a collection of SubscriberUsageAggregates, which are UsageAggregates from users.

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -AggregationGranularity
The aggregation granularity.

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

### -ContinuationToken
The continuation token.

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

### -ReportedEndTime
The reported end time (exclusive).

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ReportedStartTime
The reported start time (inclusive).

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: True
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

### -SubscriberId
The tenant subscription identifier.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Microsoft.AzureStack.Management.Commerce.Admin.Models.UsageAggregate

## NOTES

## RELATED LINKS
