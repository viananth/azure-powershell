---
external help file: Microsoft.Azure.Commands.Profile.dll-Help.xml
Module Name: Azs.Update.Admin
online version: 
schema: 2.0.0
---

# Get-AzureRmContext

## SYNOPSIS
{{Fill in the Synopsis}}

## SYNTAX

### GetSingleContext (Default)
```
Get-AzureRmContext [-DefaultProfile <IAzureContextContainer>] [[-Name] <String>]
```

### ListAllContexts
```
Get-AzureRmContext [-ListAvailable] [-DefaultProfile <IAzureContextContainer>]
```

## DESCRIPTION
{{Fill in the Description}}

## EXAMPLES

### Example 1
```
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -DefaultProfile
The credentials, account, tenant, and subscription used for communication with azure.

```yaml
Type: IAzureContextContainer
Parameter Sets: (All)
Aliases: AzureRmContext, AzureCredential

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ListAvailable
List all available contexts in the current session.

```yaml
Type: SwitchParameter
Parameter Sets: ListAllContexts
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
The name of the context

```yaml
Type: String
Parameter Sets: GetSingleContext
Aliases: 
Accepted values: Default

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### None


## OUTPUTS

### Microsoft.Azure.Commands.Profile.Models.PSAzureContext


## NOTES

## RELATED LINKS

