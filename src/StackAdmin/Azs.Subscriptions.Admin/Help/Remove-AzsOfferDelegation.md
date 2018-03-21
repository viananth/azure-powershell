---
external help file: Azs.Subscriptions.Admin-help.xml
Module Name: Azs.Subscriptions.Admin
online version: 
schema: 2.0.0
---

# Remove-AzsOfferDelegation

## SYNOPSIS
Removes the offer delegation

## SYNTAX

### OfferDelegations_Delete (Default)
```
Remove-AzsOfferDelegation -Name <String> -OfferName <String> -ResourceGroupName <String> [-Force]
```

### ResourceId_OfferDelegations_Delete
```
Remove-AzsOfferDelegation -ResourceId <String> [-Force]
```

## DESCRIPTION
Removes the offer delegation

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Remove-AzsOfferDelegation -Offer offer1 -ResourceGroupName rg1 -Name delegation1
```

## PARAMETERS

### -Force
Flag to remove the item without confirmation.

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

### -Name
Name of a offer delegation.

```yaml
Type: String
Parameter Sets: OfferDelegations_Delete
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OfferName
Name of an offer.

```yaml
Type: String
Parameter Sets: OfferDelegations_Delete
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
Parameter Sets: OfferDelegations_Delete
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ResourceId
The resource id.

```yaml
Type: String
Parameter Sets: ResourceId_OfferDelegations_Delete
Aliases: id

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

