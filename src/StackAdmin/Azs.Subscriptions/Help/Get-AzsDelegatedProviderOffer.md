---
external help file: Azs.Subscriptions-help.xml
Module Name: Azs.Subscriptions
online version: 
schema: 2.0.0
---

# Get-AzsDelegatedProviderOffer

## SYNOPSIS
Get the list of offers for the specified delegated provider.

## SYNTAX

### DelegatedProviderOffers_List (Default)
```
Get-AzsDelegatedProviderOffer -DelegatedProviderId <String> [-Skip <Int32>] [-Top <Int32>]
```

### DelegatedProviderOffers_Get
```
Get-AzsDelegatedProviderOffer -OfferName <String> -DelegatedProviderId <String> [-Skip <Int32>] [-Top <Int32>]
```

## DESCRIPTION
Get the list of offers for the specified delegated provider.

## EXAMPLES

### Example 1
```
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -DelegatedProviderId
Id of the delegated provider.

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

### -OfferName
Name of the offer.

```yaml
Type: String
Parameter Sets: DelegatedProviderOffers_Get
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

### Microsoft.AzureStack.Management.Subscriptions.Models.Offer

## NOTES

## RELATED LINKS

