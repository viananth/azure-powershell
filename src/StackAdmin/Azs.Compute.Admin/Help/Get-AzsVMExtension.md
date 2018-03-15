---
external help file: Azs.Compute.Admin-help.xml
Module Name: Azs.Compute.Admin
online version:
schema: 2.0.0
---

# Get-AzsVMExtension

## SYNOPSIS
Returns virtual machine image extensions currently available.

## SYNTAX

### List (Default)
```
Get-AzsVMExtension [-Location <String>]
```

### Get
```
Get-AzsVMExtension -Publisher <String> -Type <String> -Version <String> [-Location <String>]
```

### ResourceId
```
Get-AzsVMExtension -ResourceId <String>
```

## DESCRIPTION
Returns virtual machine image extensions.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Get-AzsVMExtension -Location "local"

Id                             Type                           Name                           Location
--                             ----                           ----                           --------
/subscriptions/0dbab76e-037...Microsoft.Compute.Admin/loc...                                local
```

### -------------------------- EXAMPLE 2 --------------------------
```
Get-AzsVMExtension -Publisher Canonical -Offer UbuntuServer -Sku 16.04-LTS -Version 1.0.0

Id                             Type                           Name                           Location
--                             ----                           ----                           --------
/subscriptions/0dbab76e-037...Microsoft.Compute.Admin/loc...                                local
```

## PARAMETERS

### -Location
{{Fill Location Description}}

```yaml
Type: String
Parameter Sets: List, Get
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Publisher
Name of the publisher.

```yaml
Type: String
Parameter Sets: Get
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
Parameter Sets: ResourceId
Aliases: id

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Type
Type of extension.

```yaml
Type: String
Parameter Sets: Get
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Version
The version of the virtual machine image extension.

```yaml
Type: String
Parameter Sets: Get
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

### Microsoft.AzureStack.Management.Compute.Admin.Models.VMExtension

## NOTES

## RELATED LINKS

