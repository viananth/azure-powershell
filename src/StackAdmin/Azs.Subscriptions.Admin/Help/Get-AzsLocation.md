---
external help file: Azs.Subscriptions.Admin-help.xml
Module Name: Azs.Subscriptions.Admin
online version: 
schema: 2.0.0
---

# Get-AzsLocation

## SYNOPSIS
Get a list of all AzureStack location.

## SYNTAX

### Locations_List (Default)
```
Get-AzsLocation
```

### Locations_Get
```
Get-AzsLocation [-Name] <String>
```

## DESCRIPTION
Get a list of all AzureStack location.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Get-AzsLocation -Location local
```

DisplayName : local
Id          : /subscriptions/0a823c45-d9e7-4812-a138-74e22213693a/providers/Microsoft.Subscriptions.Admin/locations/local
Latitude    : 
Longitude   : 
Name        : local

## PARAMETERS

### -Name
{{Fill Name Description}}

```yaml
Type: String
Parameter Sets: Locations_Get
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

### Microsoft.AzureStack.Management.Subscriptions.Admin.Models.Location

## NOTES

## RELATED LINKS

