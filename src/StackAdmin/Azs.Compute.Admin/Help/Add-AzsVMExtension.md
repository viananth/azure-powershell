---
external help file: Azs.Compute.Admin-help.xml
Module Name: Azs.Compute.Admin
online version: 
schema: 2.0.0
---

# Add-AzsVMExtension

## SYNOPSIS
Create a new virtual machine extension image.

## SYNTAX

```
Add-AzsVMExtension -Publisher <String> -Type <String> -Version <String> -SourceBlob <Object> -VmOsType <Object>
 -ComputeRole <String> [-VmScaleSetEnabled] [-SupportMultipleExtensions] [-IsSystemExtension]
 [-Location <String>] [<CommonParameters>]
```

## DESCRIPTION
Create a virtual machine extension image.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\> Add-AzsVMExtension -Location "local" -Publisher "Microsoft" -Type "MicroExtension" -Version "0.1.0" -ComputeRole "IaaS" -SourceBlob "https://github.com/Microsoft/PowerShell-DSC-for-Linux/archive/v1.1.1-294.zip" -SupportMultipleExtensions -VmOsType "Linux" "https://test.blob.local.azurestack.external/test/xenial-server-cloudimg-amd64-disk1.vhd"

Id                             Type                           Name                           Location
--                             ----                           ----                           --------
/subscriptions/0ff0bbbe-d68... Microsoft.Compute.Admin/loc...                                Local
```

Add a new platform image.

## PARAMETERS

### -ComputeRole
The type of role, IaaS or PaaS, this extension supports.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IsSystemExtension
Indicates if the extension is for the system.

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

### -Location
Location of the resource.

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

### -Publisher
Name of the publisher.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SourceBlob
URI to virtual machine extension package.

```yaml
Type: Object
Parameter Sets: (All)
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SupportMultipleExtensions
True if supports multiple extensions.

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

### -Type
Type of extension.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Version
The version of the vritual machine image extension.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -VmOsType
Target virtual machine operating system type necessary for deploying the extension handler.

```yaml
Type: Object
Parameter Sets: (All)
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -VmScaleSetEnabled
Value indicating whether the extension is enabled for virtual machine scale set support.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Microsoft.AzureStack.Management.Compute.Admin.Models.VMExtension

## NOTES

## RELATED LINKS

