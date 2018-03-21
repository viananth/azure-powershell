---
external help file: Microsoft.Azure.Commands.Profile.dll-Help.xml
Module Name: Azs.Update.Admin
online version: 
schema: 2.0.0
---

# Resolve-AzureRmError

## SYNOPSIS
{{Fill in the Synopsis}}

## SYNTAX

### AnyErrorParameterSet (Default)
```
Resolve-AzureRmError [[-Error] <ErrorRecord[]>] [-DefaultProfile <IAzureContextContainer>]
```

### LastErrorParameterSet
```
Resolve-AzureRmError [-Last] [-DefaultProfile <IAzureContextContainer>]
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

### -Error
The error records to resolve

```yaml
Type: ErrorRecord[]
Parameter Sets: AnyErrorParameterSet
Aliases: 

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Last
The last error

```yaml
Type: SwitchParameter
Parameter Sets: LastErrorParameterSet
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### System.Management.Automation.ErrorRecord[]


## OUTPUTS

### Microsoft.Azure.Commands.Profile.Errors.AzureErrorRecord
Microsoft.Azure.Commands.Profile.Errors.AzureExceptionRecord
Microsoft.Azure.Commands.Profile.Errors.AzureRestExceptionRecord


## NOTES

## RELATED LINKS

