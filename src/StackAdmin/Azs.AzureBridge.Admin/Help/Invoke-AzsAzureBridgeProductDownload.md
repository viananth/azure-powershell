---
external help file: Azs.Azurebridge.Admin-help.xml
Module Name: Azs.AzureBridge.Admin
online version:
schema: 2.0.0
---

# Invoke-AzsAzureBridgeProductDownload

## SYNOPSIS
Downloads a product from azure marketplace.

## SYNTAX

### Products_Download (Default)
```
Invoke-AzsAzureBridgeProductDownload -ActivationName <String> -ProductName <String> -ResourceGroupName <String>
 [-AsJob]
```

### InputObject_Products_Download
```
Invoke-AzsAzureBridgeProductDownload -InputObject <ProductResource> [-AsJob]
```

## DESCRIPTION
Downloads a product from azure marketplace.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\> Invoke-AzsAzureBridgeProductDownload -ActivationName 'myActivation' -ProductName 'microsoft.docker-arm.1.1.0' -ResourceGroupName 'activationRG'
```

Download a product from Azure Marketplace

## PARAMETERS

### -ActivationName
Name of the activation.

```yaml
Type: String
Parameter Sets: Products_Download
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

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

### -InputObject
The input object of type Microsoft.AzureStack.Management.AzureBridge.Admin.Models.ProductResource.

```yaml
Type: ProductResource
Parameter Sets: InputObject_Products_Download
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -ProductName
Name of the product.

```yaml
Type: String
Parameter Sets: Products_Download
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
Parameter Sets: Products_Download
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

