---
external help file: Azs.Subscriptions.Admin-help.xml
Module Name: Azs.Subscriptions.Admin
online version: 
schema: 2.0.0
---

# Get-AzsPlan

## SYNOPSIS
List all plans across all subscriptions.

## SYNTAX

### Plans_ListAll (Default)
```
Get-AzsPlan [-Skip <Int32>] [-Top <Int32>]
```

### Plans_Get
```
Get-AzsPlan -Name <String> -ResourceGroupName <String>
```

### Plans_List
```
Get-AzsPlan -ResourceGroupName <String> [-Skip <Int32>] [-Top <Int32>]
```

### ResourceId_Plans_Get
```
Get-AzsPlan -ResourceId <String>
```

## DESCRIPTION
List all plans across all subscriptions.

## EXAMPLES

### Example 1
```
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -Name
Name of the plan.

```yaml
Type: String
Parameter Sets: Plans_Get
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
Parameter Sets: Plans_Get, Plans_List
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
Parameter Sets: ResourceId_Plans_Get
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
Parameter Sets: Plans_ListAll, Plans_List
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
Parameter Sets: Plans_ListAll, Plans_List
Aliases: 

Required: False
Position: Named
Default value: -1
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

### Microsoft.AzureStack.Management.Subscriptions.Admin.Models.Plan

## NOTES

## RELATED LINKS

