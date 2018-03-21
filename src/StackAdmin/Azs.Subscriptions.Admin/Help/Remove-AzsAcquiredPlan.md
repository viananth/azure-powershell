---
external help file: Azs.Subscriptions.Admin-help.xml
Module Name: Azs.Subscriptions.Admin
online version: 
schema: 2.0.0
---

# Remove-AzsAcquiredPlan

## SYNOPSIS
Deletes an acquired plan.

## SYNTAX

### AcquiredPlans_Delete (Default)
```
Remove-AzsAcquiredPlan -AcquisitionId <Guid> -TargetSubscriptionId <String> [-Force] [<CommonParameters>]
```

### ResourceId_AcquiredPlans_Delete
```
Remove-AzsAcquiredPlan -ResourceId <String> [-Force] [<CommonParameters>]
```

## DESCRIPTION
Deletes an acquired plan.

## EXAMPLES

### Example 1
```
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -AcquisitionId
{{Fill AcquisitionId Description}}

```yaml
Type: Guid
Parameter Sets: AcquiredPlans_Delete
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force
Flag to remove the item without confirmation.

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

### -ResourceId
The resource id.

```yaml
Type: String
Parameter Sets: ResourceId_AcquiredPlans_Delete
Aliases: id

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -TargetSubscriptionId
The target subscription ID.

```yaml
Type: String
Parameter Sets: AcquiredPlans_Delete
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

