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
Stop-AzsContainerMigration -OperationId <String> [-ResourceGroupName <String>] -FarmName <String> [-AsJob]
```

### ResourceId_Containers_CancelMigration
```
Stop-AzsContainerMigration -ResourceId <String> [-AsJob]
```

### InputObject_Containers_CancelMigration
```
Stop-AzsContainerMigration -InputObject <MigrationResult> [-AsJob]
```

## DESCRIPTION
Cancel a container migration job.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Stop-AzsContainerMigration -FarmName "342fccbe-e8c0-468d-a90e-cfca5fa8877c" -OperationId "ac8cde1b-804f-4ace-b39b-5322106703bf"
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

### -InputObject
The input object of type Microsoft.AzureStack.Management.Storage.Admin.Models.MigrationResult.

```yaml
Type: MigrationResult
Parameter Sets: InputObject_Containers_CancelMigration
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -OperationId
{{Fill OperationId Description}}

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

