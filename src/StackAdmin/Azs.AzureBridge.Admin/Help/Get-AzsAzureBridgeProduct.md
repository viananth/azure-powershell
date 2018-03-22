---
external help file: Azs.Azurebridge.Admin-help.xml
Module Name: Azs.AzureBridge.Admin
online version:
schema: 2.0.0
---

# Get-AzsAzureBridgeProduct

## SYNOPSIS
Returns a list of products available for download from Azure Marketplace.

## SYNTAX

### Products_List (Default)
```
Get-AzsAzureBridgeProduct -ActivationName <String> -ResourceGroupName <String> [-Skip <Int32>] [-Top <Int32>]
 [<CommonParameters>]
```

### Products_Get
```
Get-AzsAzureBridgeProduct -Name <String> -ActivationName <String> -ResourceGroupName <String>
 [<CommonParameters>]
```

### ResourceId_Products_Get
```
Get-AzsAzureBridgeProduct -ResourceId <String> [<CommonParameters>]
```

## DESCRIPTION
Returns a list of products available for download from Azure Marketplace.

## EXAMPLES

### EXAMPLE 1
```
# Get a list of Products available for download from Azure Marketplace.
```

Get-AzsAzureBridgeProduct -ActivationName 'myActivation' -ResourceGroupName 'activationRG'

### EXAMPLE 2
```
# Get a product info available for download from Azure Marketplace by Name.
```

Get-AzsAzureBridgeProduct -ActivationName 'myActivation' -ResourceGroupName 'activationRG' -Name 'microsoft.docker-arm.1.1.0'

## PARAMETERS

### -ActivationName
Name of the activation.

```yaml
Type: String
Parameter Sets: Products_List, Products_Get
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Name of the product.

```yaml
Type: String
Parameter Sets: Products_Get
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
Parameter Sets: Products_List, Products_Get
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ResourceId
The resource id.

```yaml
Type: String
Parameter Sets: ResourceId_Products_Get
Aliases: id

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
Parameter Sets: Products_List
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
Parameter Sets: Products_List
Aliases:

Required: False
Position: Named
Default value: -1
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Microsoft.AzureStack.Management.AzureBridge.Admin.Models.ProductResource

## NOTES

## RELATED LINKS
