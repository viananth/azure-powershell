---
external help file: Azs.Subscriptions.Admin-help.xml
Module Name: Azs.Subscriptions.Admin
online version:
schema: 2.0.0
---

# Set-AzsOffer

## SYNOPSIS
Update the offer.

## SYNTAX

### Offers_CreateOrUpdate (Default)
```
Set-AzsOffer -Name <String> -ResourceGroupName <String> [-DisplayName <String>] [-BasePlanIds <String[]>]
 [-Description <String>] [-ExternalReferenceId <String>] [-State <String>] [-Location <String>]
 [-SubscriptionCount <Int64>] [-MaxSubscriptionsPerAccount <Int64>]
 [-AddonPlanDefinition <AddonPlanDefinition[]>] [<CommonParameters>]
```

### InputObject_Offers_CreateOrUpdate
```
Set-AzsOffer [-DisplayName <String>] [-BasePlanIds <String[]>] -InputObject <Offer> [-Description <String>]
 [-ExternalReferenceId <String>] [-State <String>] [-Location <String>] [-SubscriptionCount <Int64>]
 [-MaxSubscriptionsPerAccount <Int64>] [-AddonPlanDefinition <AddonPlanDefinition[]>] [<CommonParameters>]
```

### ResourceId_Offers_CreateOrUpdate
```
Set-AzsOffer [-DisplayName <String>] [-BasePlanIds <String[]>] [-Description <String>]
 [-ExternalReferenceId <String>] [-State <String>] [-Location <String>] [-SubscriptionCount <Int64>]
 [-MaxSubscriptionsPerAccount <Int64>] [-AddonPlanDefinition <AddonPlanDefinition[]>] -ResourceId <String>
 [<CommonParameters>]
```

## DESCRIPTION
Update the offer.

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -AddonPlanDefinition
References to add-on plans that a tenant can optionally acquire as a part of the offer.

```yaml
Type: AddonPlanDefinition[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -BasePlanIds
Identifiers of the base plans that become available to the tenant immediately when a tenant subscribes to the offer.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Description
Description of offer.

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

### -DisplayName
Display name of offer.

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

### -ExternalReferenceId
External reference identifier.

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

### -InputObject
The input object of type Microsoft.AzureStack.Management.Subscriptions.Admin.Models.Offer.

```yaml
Type: Offer
Parameter Sets: InputObject_Offers_CreateOrUpdate
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

### -MaxSubscriptionsPerAccount
Maximum subscriptions per account.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Name of an offer.

```yaml
Type: String
Parameter Sets: Offers_CreateOrUpdate
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
Parameter Sets: Offers_CreateOrUpdate
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
Parameter Sets: ResourceId_Offers_CreateOrUpdate
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -State
Offer accessibility state.

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

### -SubscriptionCount
Current subscription count.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
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
