---
external help file: Azs.InfrastructureInsights.Admin-help.xml
Module Name: Azs.InfrastructureInsights.Admin
online version: 
schema: 2.0.0
---

# Get-AzsRegistrationHealth

## SYNOPSIS
Returns a list of each resource's health under a service.

## SYNTAX

### ResourceHealths_List (Default)
```
Get-AzsRegistrationHealth -ServiceRegistrationId <String> [-Location <String>] [-ResourceGroupName <String>]
 [-Filter <String>] [-Top <Int32>] [-Skip <Int32>] [<CommonParameters>]
```

### ResourceHealths_Get
```
Get-AzsRegistrationHealth -ServiceRegistrationId <String> -ResourceRegistrationId <String> [-Location <String>]
 [-ResourceGroupName <String>] [-Filter <String>] [<CommonParameters>]
```

### ResourceId_ResourceHealths_Get
```
Get-AzsRegistrationHealth -ResourceId <String> [-Filter <String>] [<CommonParameters>]
```

## DESCRIPTION
Returns a list of each resource's health under a service.

## EXAMPLES

### Example 1
```
PS C:\> Get-AzsRegistrationHealth -ResourceGroupName System.local -Region local -ServiceRegistrationId e56bc7b8-c8b5-4e25-b00c-4f951effb22c

Resource HealthSt Tags     Type     RpRegist Name     Resource Registra Resource Resource Resource Id       RoutePre Location Namespace
Type     ate                        rationId          DisplayN tionId   Name     Location URI               fix
                                                      ame
-------- -------- ----     ----     -------- ----     -------- -------- -------- -------- -------- --       -------- -------- ---------
infra... Warning  {}       Micro... e56bc... 051f3... Parti... 051f3... NonPr... local    /subs... /subs... /subs... local
infra... Healthy  {}       Micro... e56bc... 1411b... Galle... 1411b... Galle... local    /subs... /subs... /subs... local
infra... Healthy  {}       Micro... e56bc... 1720e... Key V... 1720e... KeyVa... local    /subs... /subs... /subs... local
infra... Healthy  {}       Micro... e56bc... 198ff... Netwo... 198ff... Netwo... local    /subs... /subs... /subs... local
infra... Healthy  {}       Micro... e56bc... 1df85... Key V... 1df85... KeyVa... local    /subs... /subs... /subs... local
infra... Healthy  {}       Micro... e56bc... 1fed1... Healt... 1fed1... Healt... local    /subs... /subs... /subs... local
infra... Unknown  {}       Micro... e56bc... 2b91e... Certi... 2b91e... Activ... local    /subs... /subs... /subs... local
```

Return all infrastructure roles health status under a service.

### Example 2
```
PS C:\> $regs = Get-AzsRegistrationHealth -ResourceGroupName System.local -Region local -ServiceRegistrationId e56bc7b8-c8b5-4e25-b00c-4f951effb22c -ResourceRegistrationId 1fed1cff-e15b-4c2e-b349-e4e169ed0900

Resource HealthSt Tags     Type     RpRegist Name     Resource Registra Resource Resource Resource Id       RoutePre Location Namespace
Type     ate                        rationId          DisplayN tionId   Name     Location URI               fix
                                                      ame
-------- -------- ----     ----     -------- ----     -------- -------- -------- -------- -------- --       -------- -------- ---------
infra... Healthy  {}       Micro... e56bc... 1fed1... Healt... 1fed1... Healt... local    /subs... /subs... /subs... local
```

Return the infrastructure roles health status.

## PARAMETERS

### -Filter
OData filter parameter.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Location
Name of the region```yaml
Type: String
Parameter Sets: ResourceHealths_List, ResourceHealths_Get
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ResourceGroupName
resourceGroupName.

```yaml
Type: String
Parameter Sets: ResourceHealths_List, ResourceHealths_Get
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
Parameter Sets: ResourceId_ResourceHealths_Get
Aliases: id

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ResourceRegistrationId
{{Fill ResourceRegistrationId Description}}

```yaml
Type: String
Parameter Sets: ResourceHealths_Get
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ServiceRegistrationId
Service registration id.

```yaml
Type: String
Parameter Sets: ResourceHealths_List, ResourceHealths_Get
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Skip
Skip the first N items as specified by the parameter value.

```yaml
Type: Int32
Parameter Sets: ResourceHealths_List
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
Parameter Sets: ResourceHealths_List
Aliases: 

Required: False
Position: Named
Default value: -1
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Microsoft.AzureStack.Management.InfrastructureInsights.Admin.Models.ResourceHealth

## NOTES

## RELATED LINKS

