---
external help file: Azs.Storage.Admin-help.xml
Module Name: Azs.Storage.Admin
online version: 
schema: 2.0.0
---

# Stop-AzsContainerMigration

## SYNOPSIS
Cancel a container migration job.

## SYNTAX

### Containers_CancelMigration (Default)
```
Stop-AzsContainerMigration -JobId <String> [-ResourceGroupName <String>] -FarmName <String> [-AsJob]
 [<CommonParameters>]
```

### ResourceId_Containers_CancelMigration
```
Stop-AzsContainerMigration -ResourceId <String> [-AsJob] [<CommonParameters>]
```

## DESCRIPTION
Cancel a container migration job.

## EXAMPLES

### EXAMPLE 1
```
Stop-AzsContainerMigration -FarmName "342fccbe-e8c0-468d-a90e-cfca5fa8877c" -JobId "ac8cde1b-804f-4ace-b39b-5322106703bf"
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

### -FarmName
Farm Id.

```yaml
Type: String
Parameter Sets: Containers_CancelMigration
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -JobId
{{Fill JobId Description}}

```yaml
Type: String
Parameter Sets: Containers_CancelMigration
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
Parameter Sets: Containers_CancelMigration
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
Parameter Sets: ResourceId_Containers_CancelMigration
Aliases: id

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

