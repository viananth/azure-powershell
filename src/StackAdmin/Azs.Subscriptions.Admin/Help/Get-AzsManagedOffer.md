---
external help file: Azs.Subscriptions.Admin-help.xml
Module Name: Azs.Subscriptions.Admin
online version:
schema: 2.0.0
---

# Get-AzsManagedOffer

## SYNOPSIS
Get the list of offers as the administrator.

## SYNTAX

### Offers_ListAll (Default)
```
Get-AzsManagedOffer [-Skip <Int32>] [-Top <Int32>] [<CommonParameters>]
```

### Offers_Get
```
Get-AzsManagedOffer -Name <String> -ResourceGroupName <String> [<CommonParameters>]
```

### Offers_List
```
Get-AzsManagedOffer -ResourceGroupName <String> [-Skip <Int32>] [-Top <Int32>] [<CommonParameters>]
```

### ResourceId_Offers_Get
```
Get-AzsManagedOffer -ResourceId <String> [<CommonParameters>]
```

## DESCRIPTION
Get the list of offers.

## EXAMPLES

### EXAMPLE 1
```
Get-AzsManagedOffer -Name offer -ResourceGroupName offerrg
```

OfferName                  : offer
DisplayName                : offer
Description                :
ExternalReferenceId        :
State                      : Public
SubscriptionCount          : 1
MaxSubscriptionsPerAccount : 0
BasePlanIds                : {/subscriptions/0a823c45-d9e7-4812-a138-74e22213693a/resourceGroups/offerrg/providers/Microsoft.Subscriptions.Admin/plans/plan1}
AddonPlanDefinition        :
Id                         : /subscriptions/0a823c45-d9e7-4812-a138-74e22213693a/resourceGroups/offerrg/providers/Microsoft.Subscriptions.Admin/offers/offer
Name                       : offer
Type                       : Microsoft.Subscriptions.Admin/offers
Location                   : local

## PARAMETERS

### -Name
Name of an offer.

```yaml
Type: String
Parameter Sets: Offers_Get
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
Parameter Sets: Offers_Get, Offers_List
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
Parameter Sets: ResourceId_Offers_Get
Aliases: id

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Skip
Skip the first N items as specified by the parameter value.

```yaml
Type: Int32
Parameter Sets: Offers_ListAll, Offers_List
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
Parameter Sets: Offers_ListAll, Offers_List
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

### Microsoft.AzureStack.Management.Subscriptions.Admin.Models.Offer

## NOTES

## RELATED LINKS
