---
external help file: Azs.Subscriptions.Admin-help.xml
Module Name: Azs.Subscriptions.Admin
online version: 
schema: 2.0.0
---

# Test-AzsNameAvailability

## SYNOPSIS
Returns the avaialbility of the specified subscriptions resource type and name

## SYNTAX

```
Test-AzsNameAvailability -Name <String> -ResourceType <String>
```

## DESCRIPTION
Returns the avaialbility of the specified subscriptions resource type and name

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Test-AzsNameAvailability -ResourceType "Microsoft.Subscriptions.Admin/offers" -Name offername1
```

## PARAMETERS

### -Name
The resource name to verify.

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

### -ResourceType
The resource type to verify.

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

### Microsoft.AzureStack.Management.Subscriptions.Admin.Models.CheckNameAvailabilityResponse

## NOTES

## RELATED LINKS

