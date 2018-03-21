---
external help file: Azs.Update.Admin-help.xml
Module Name: Azs.Update.Admin
online version: 
schema: 2.0.0
---

# Get-AzsUpdateLocation

## SYNOPSIS
Get the list of update locations.

## SYNTAX

### UpdateLocations_List (Default)
```
Get-AzsUpdateLocation [-ResourceGroupName <String>]
```

### UpdateLocations_Get
```
Get-AzsUpdateLocation [-Location <String>] [-ResourceGroupName <String>]
```

### ResourceId_UpdateLocations_Get
```
Get-AzsUpdateLocation -ResourceId <String>
```

### InputObject_UpdateLocations_Get
```
Get-AzsUpdateLocation -InputObject <UpdateLocation>
```

## DESCRIPTION
Get the list of update locations. 
The locations returned can be used to get available updates at a particular location using Get-AzsUpdate.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Get-AzsUpdateLocation
```

CurrentVersion    : 1.0.180302.1
CurrentOemVersion : 1.0.1709.3
LastUpdated       : 3/3/2018 8:09:12 AM
State             : UpdateAvailable
Id                : /subscriptions/23d66fd1-4743-42ff-b391-e29dc51d799e/resourceGroups/System.redmond/providers/Microsoft.Update.Admin/updateLocations/redmond
Name              : redmond
Type              : Microsoft.Update.Admin/updateLocations
Location          : redmond
Tags              : {}

## PARAMETERS

### -InputObject
The input object of type Microsoft.AzureStack.Management.Update.Admin.Models.UpdateLocation.

```yaml
Type: UpdateLocation
Parameter Sets: InputObject_UpdateLocations_Get
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Location
{{Fill Location Description}}

```yaml
Type: String
Parameter Sets: UpdateLocations_Get
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ResourceGroupName
The resource group the resource is located under.

```yaml
Type: String
Parameter Sets: UpdateLocations_List, UpdateLocations_Get
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ResourceId
The resource id.

```yaml
Type: String
Parameter Sets: ResourceId_UpdateLocations_Get
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

### Microsoft.AzureStack.Management.Update.Admin.Models.UpdateLocation

## NOTES

## RELATED LINKS

