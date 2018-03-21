---
external help file: Azs.Subscriptions.Admin-help.xml
Module Name: Azs.Subscriptions.Admin
online version: 
schema: 2.0.0
---

# Get-AzsOfferMetricDefinition

## SYNOPSIS
Get the offer metric definitions.

## SYNTAX

```
Get-AzsOfferMetricDefinition -OfferName <String> -ResourceGroupName <String>
```

## DESCRIPTION
Get the offer metric definitions.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Get-AzsOfferMetricDefinition -ResourceGroupName rg1 -OfferName offername1
```

## PARAMETERS

### -OfferName
Name of an offer.

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
{{Fill ResourceGroupName Description}}

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

### Microsoft.AzureStack.Management.Subscriptions.Admin.Models.MetricDefinition

## NOTES

## RELATED LINKS

