---
external help file: Azs.Storage.Admin-help.xml
Module Name: Azs.Storage.Admin
online version: 
schema: 2.0.0
---

# Get-AzsStorageFarm

## SYNOPSIS
Returns a list of all storage farms.

## SYNTAX

### Farms_List (Default)
```
Get-AzsStorageFarm [-Skip <Int32>] [-ResourceGroupName <String>] [-Top <Int32>]
```

### Farms_Get
```
Get-AzsStorageFarm [-ResourceGroupName <String>] -Name <String>
```

### ResourceId_Farms_Get
```
Get-AzsStorageFarm -ResourceId <String>
```

### InputObject_Farms_Get
```
Get-AzsStorageFarm -InputObject <Farm>
```

## DESCRIPTION
Returns a list of all storage farms.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Get-AzsStorageFarm -ResourceGroupName "system.local"
```

Name              Location          HealthStatus      SettingsStore
----              --------          ------------      -------------
f9b8e2e2-e4b4-...
local                               ASACSSFClient....

## PARAMETERS

### -InputObject
The input object of type Microsoft.AzureStack.Management.Storage.Admin.Models.Farm.

```yaml
Type: Farm
Parameter Sets: InputObject_Farms_Get
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Name
Farm Id.

```yaml
Type: String
Parameter Sets: Farms_Get
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ResourceGroupName
Resource group name.

```yaml
Type: String
Parameter Sets: Farms_List, Farms_Get
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
Parameter Sets: ResourceId_Farms_Get
Aliases: 

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
Parameter Sets: Farms_List
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
Parameter Sets: Farms_List
Aliases: 

Required: False
Position: Named
Default value: -1
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

### Microsoft.AzureStack.Management.Storage.Admin.Models.Farm

## NOTES

## RELATED LINKS

