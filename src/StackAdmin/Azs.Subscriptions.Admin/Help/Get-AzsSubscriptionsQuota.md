---
external help file: Azs.Subscriptions.Admin-help.xml
Module Name: Azs.Subscriptions.Admin
online version: 
schema: 2.0.0
---

# Get-AzsSubscriptionsQuota

## SYNOPSIS
Get the list of subscription resource provider quotas at a location.

## SYNTAX

### Quotas_List (Default)
```
Get-AzsSubscriptionsQuota [-Location <String>]
```

### Quotas_Get
```
Get-AzsSubscriptionsQuota -Name <String> [-Location <String>]
```

### ResourceId_Quotas_Get
```
Get-AzsSubscriptionsQuota -ResourceId <String>
```

## DESCRIPTION
Get the list of quotas at a location.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Get-AzsSubscriptionsQuota
```

AllowCustomPortalBranding : False
Id                        : /subscriptions/0a823c45-d9e7-4812-a138-74e22213693a/providers/Microsoft.Subscriptions.Admin/locations/local/quotas/delegatedProviderQuota
Name                      : local/delegatedProviderQuota
Type                      : Microsoft.Subscriptions.Admin/locations/quotas
Location                  : local
Tags                      :

## PARAMETERS

### -Location
The AzureStack location.

```yaml
Type: String
Parameter Sets: Quotas_List, Quotas_Get
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Name of the quota.

```yaml
Type: String
Parameter Sets: Quotas_Get
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
Parameter Sets: ResourceId_Quotas_Get
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

### Microsoft.AzureStack.Management.Subscriptions.Admin.Models.Quota

## NOTES

## RELATED LINKS

