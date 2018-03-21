---
external help file: Microsoft.Azure.Commands.Profile.dll-Help.xml
Module Name: AzureRM.Profile
online version: 
schema: 2.0.0
---

# Resolve-AzureRmError

## SYNOPSIS
{{Fill in the Synopsis}}

## SYNTAX

### AnyErrorParameterSet (Default)
```
Resolve-AzureRmError [[-Error] <ErrorRecord[]>] [-DefaultProfile <IAzureContextContainer>] [<CommonParameters>]
```

### LastErrorParameterSet
```
Resolve-AzureRmError [-Last] [-DefaultProfile <IAzureContextContainer>] [<CommonParameters>]
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Management.Automation.ErrorRecord[]

## OUTPUTS

### Microsoft.Azure.Commands.Profile.Errors.AzureErrorRecord
Microsoft.Azure.Commands.Profile.Errors.AzureExceptionRecord
Microsoft.Azure.Commands.Profile.Errors.AzureRestExceptionRecord

## NOTES

## RELATED LINKS

