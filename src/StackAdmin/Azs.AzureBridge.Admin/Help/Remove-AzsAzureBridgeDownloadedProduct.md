---
external help file: Azs.Azurebridge.Admin-help.xml
Module Name: Azs.AzureBridge.Admin
online version:
schema: 2.0.0
---

# Remove-AzsAzureBridgeDownloadedProduct

## SYNOPSIS
Delete a product downloaded from Azure MarketPlace.

## SYNTAX

### DownloadedProducts_Delete
```
Remove-AzsAzureBridgeDownloadedProduct -Name <String> -ActivationName <String> -ResourceGroupName <String>
 [-Force] [-AsJob] [-WhatIf] [-Confirm]
```

### InputObject_DownloadedProducts_Delete
```
Remove-AzsAzureBridgeDownloadedProduct [-Force] -InputObject <DownloadedProductResource> [-AsJob] [-WhatIf]
 [-Confirm]
```

### ResourceId_DownloadedProducts_Delete
```
Remove-AzsAzureBridgeDownloadedProduct [-Force] -ResourceId <String> [-AsJob] [-WhatIf] [-Confirm]
```

## DESCRIPTION
Delete a product downloaded from Azure MarketPlace.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\> Remove-AzsAzureBridgeDownloadedProduct -ActivationName 'myActivation' -ProductName 'microsoft.docker-arm.1.1.0' -ResourceGroupName 'activationRG'
```

Delete a product downloaded from Azure Marketplace

## PARAMETERS

### -ActivationName
Name of the activation.

```yaml
Type: String
Parameter Sets: DownloadedProducts_Delete
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

### -Force
{{Fill Force Description}}

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
The input object of type Microsoft.AzureStack.Management.AzureBridge.Admin.Models.DownloadedProductResource.

```yaml
Type: DownloadedProductResource
Parameter Sets: InputObject_DownloadedProducts_Delete
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Name
Name of the product.

```yaml
Type: String
Parameter Sets: DownloadedProducts_Delete
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
Parameter Sets: DownloadedProducts_Delete
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
Parameter Sets: ResourceId_DownloadedProducts_Delete
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

### Microsoft.AzureStack.Management.AzureBridge.Admin.Models.DownloadedProductResource

## NOTES

## RELATED LINKS

