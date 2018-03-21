---
external help file: Azs.Subscriptions.Admin-help.xml
Module Name: Azs.Subscriptions.Admin
online version: 
schema: 2.0.0
---

# Set-AzsOfferDelegation

## SYNOPSIS
Updates the offer delegation.

## SYNTAX

### OfferDelegations_CreateOrUpdate (Default)
```
Set-AzsOfferDelegation -Name <String> -OfferName <String> -ResourceGroupName <String>
 [-SubscriptionId <String>] [-Location <String>]
```

### InputObject_OfferDelegations_CreateOrUpdate
```
Set-AzsOfferDelegation [-SubscriptionId <String>] [-Location <String>] -InputObject <OfferDelegation>
```

### ResourceId_OfferDelegations_CreateOrUpdate
```
Set-AzsOfferDelegation [-SubscriptionId <String>] -ResourceId <String> [-Location <String>]
```

## DESCRIPTION
Updates the offer delegation.

## EXAMPLES

### Example 1
```
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -InputObject
The input object of type Microsoft.AzureStack.Management.Subscriptions.Admin.Models.OfferDelegation.

```yaml
Type: OfferDelegation
Parameter Sets: InputObject_OfferDelegations_CreateOrUpdate
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Location
Location of the resource.

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

### -Name
Name of a offer delegation.

```yaml
Type: String
Parameter Sets: OfferDelegations_CreateOrUpdate
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
Parameter Sets: OfferDelegations_CreateOrUpdate
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
Parameter Sets: OfferDelegations_CreateOrUpdate
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
Parameter Sets: ResourceId_OfferDelegations_CreateOrUpdate
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SubscriptionId
Identifier of the subscription receiving the delegated offer.

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

### Microsoft.AzureStack.Management.Subscriptions.Admin.Models.OfferDelegation

## NOTES

## RELATED LINKS

