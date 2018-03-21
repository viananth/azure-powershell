---
external help file: Azs.Update.Admin-help.xml
Module Name: Azs.Update.Admin
online version: 
schema: 2.0.0
---

# Get-AzsUpdateRun

## SYNOPSIS
Get the list of update runs.

## SYNTAX

### UpdateRuns_List (Default)
```
Get-AzsUpdateRun [-Location <String>] [-Skip <Int32>] [-Top <Int32>] [-ResourceGroupName <String>]
 -UpdateName <String>
```

### UpdateRuns_Get
```
Get-AzsUpdateRun -Name <String> [-Location <String>] [-ResourceGroupName <String>] -UpdateName <String>
```

### ResourceId_UpdateRuns_Get
```
Get-AzsUpdateRun -ResourceId <String>
```

### InputObject_UpdateRuns_Get
```
Get-AzsUpdateRun -InputObject <Update>
```

## DESCRIPTION
Get the list of update runs. 
Instances of the UpdateRun objects returned can be piped to Restart-AzsUpdateRun, when applicable.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Get-AzsUpdateRun -UpdateName Microsoft1.0.180302.1
```

Progress    : Microsoft.AzureStack.Management.Update.Admin.Models.Step
TimeStarted : 3/2/2018 5:25:22 PM
Duration    : PT14H43M50.0644552S
State       : Succeeded
Id          : /subscriptions/23d66fd1-4743-42ff-b391-e29dc51d799e/resourceGroups/System.redmond/providers/Microsoft.Update.Admin/updateLocations/redmond/
			  updates/Microsoft1.0.180302.1/updateRuns/407d9b8f-debf-4058-b374-a94a1bb4de30
Name        : 407d9b8f-debf-4058-b374-a94a1bb4de30
Type        : Microsoft.Update.Admin/updateLocations/updates/updateRuns
Location    : redmond
Tags        : {}

## PARAMETERS

### -InputObject
The input object of type Microsoft.AzureStack.Management.Update.Admin.Models.UpdateRun.

```yaml
Type: Update
Parameter Sets: InputObject_UpdateRuns_Get
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Location
The name of the update location.

```yaml
Type: String
Parameter Sets: UpdateRuns_List, UpdateRuns_Get
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Update run identifier.

```yaml
Type: String
Parameter Sets: UpdateRuns_Get
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ResourceGroupName
The resource group the resource is located under.

```yaml
Type: String
Parameter Sets: UpdateRuns_List, UpdateRuns_Get
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
Parameter Sets: ResourceId_UpdateRuns_Get
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
Parameter Sets: UpdateRuns_List
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
Parameter Sets: UpdateRuns_List
Aliases: 

Required: False
Position: Named
Default value: -1
Accept pipeline input: False
Accept wildcard characters: False
```

### -UpdateName
Name of the update.

```yaml
Type: String
Parameter Sets: UpdateRuns_List, UpdateRuns_Get
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

### Microsoft.AzureStack.Management.Update.Admin.Models.UpdateRun

## NOTES

## RELATED LINKS

