---
external help file: Azs.Network.Admin-help.xml
Module Name: Azs.Network.Admin
online version: 
schema: 2.0.0
---

# Remove-AzsNetworkQuota

## SYNOPSIS
Delete a quota by name.

## SYNTAX

### Quotas_Delete (Default)
```
Remove-AzsNetworkQuota -Name <String> [-Location <String>] [-AsJob]
```

### ResourceId_Quotas_Delete
```
Remove-AzsNetworkQuota -ResourceId <String> [-AsJob]
```

### InputObject_Quotas_Delete
```
Remove-AzsNetworkQuota -InputObject <Quota> [-AsJob]
```

## DESCRIPTION
Delete a quota by name.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Get-AzsNetworkQuota -Name NetworkQuota1 | Remove-AzsNetworkQuota
```

### -------------------------- EXAMPLE 2 --------------------------
```
Remove-AzsNetworkQuota -Name NetworkQuota1
```

## PARAMETERS

### -AsJob
{{Fill AsJob Description}}

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
The input object of type Microsoft.AzureStack.Management.Network.Admin.Models.Quota.

```yaml
Type: Quota
Parameter Sets: InputObject_Quotas_Delete
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
Parameter Sets: Quotas_Delete
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Name of the resource.

```yaml
Type: String
Parameter Sets: Quotas_Delete
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
Parameter Sets: ResourceId_Quotas_Delete
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

