---
external help file: Azs.Subscriptions.Admin-help.xml
Module Name: Azs.Subscriptions.Admin
online version: 
schema: 2.0.0
---

# Remove-AzsOffer

## SYNOPSIS
Delete the specified offer.

## SYNTAX

### Offers_Delete (Default)
```
Remove-AzsOffer -Name <String> -ResourceGroupName <String> [-Force] [<CommonParameters>]
```

### ResourceId_Offers_Delete
```
Remove-AzsOffer -ResourceId <String> [-Force] [<CommonParameters>]
```

### InputObject_Offers_Delete
```
Remove-AzsOffer -InputObject <Offer> [-Force] [<CommonParameters>]
```

## DESCRIPTION
Delete the specified offer.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Remove-AzsOffer -Name offername1 -ResourceGroupName rg1
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

### -InputObject
The input object of type Microsoft.AzureStack.Management.Subscriptions.Admin.Models.Offer.```yaml
Type: Offer
Parameter Sets: InputObject_Offers_Delete
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Name
Name of an offer.

```yaml
Type: String
Parameter Sets: Offers_Delete
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
Parameter Sets: Offers_Delete
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
Parameter Sets: ResourceId_Offers_Delete
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

