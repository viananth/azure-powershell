---
external help file: Azs.Storage.Admin-help.xml
Module Name: Azs.Storage.Admin
online version:
schema: 2.0.0
---

# Get-AzsStorageContainerMigration

## SYNOPSIS
Returns the status of a container migration job.

## SYNTAX

### Containers_MigrationStatus (Default)
```
Get-AzsStorageContainerMigration -JobId <String> [-ResourceGroupName <String>] -FarmName <String>
```

### ResourceId_Containers_MigrationStatus
```
Get-AzsStorageContainerMigration -ResourceId <String>
```

### InputObject_Containers_MigrationStatus
```
Get-AzsStorageContainerMigration -InputObject <MigrationResult>
```

## DESCRIPTION
Returns the status of a container migration job.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Get-AzsStorageContainerMigration -FarmName "6ed442a3-ec47-4145-b2f0-9b90377b01d0" -JobId "6478ef3b-b7d5-4827-8d47-551c6afb9dd4"
```

jobId                : 6478ef3b-b7d5-4827-8d47-551c6afb9dd4
sourceShareName      : testSourceShare
StorageAccountName   : testStorageAccount
ContainerName        : testContainer
DestinationShareName : \\\\127.0.0.1\C$\Share
MigrationStatus      : Active
SubEntitiesCompleted : 0
SubEntitiesFailed    : 0
FailureReason        :

## PARAMETERS

### -FarmName
Farm Id.

```yaml
Type: String
Parameter Sets: Containers_MigrationStatus
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
Parameter Sets: InputObject_Containers_MigrationStatus
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -JobId
The job id for the migration job.

```yaml
Type: String
Parameter Sets: Containers_MigrationStatus
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
Parameter Sets: Containers_MigrationStatus
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
Parameter Sets: ResourceId_Containers_MigrationStatus
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

### Microsoft.AzureStack.Management.Storage.Admin.Models.MigrationResult

## NOTES

## RELATED LINKS

