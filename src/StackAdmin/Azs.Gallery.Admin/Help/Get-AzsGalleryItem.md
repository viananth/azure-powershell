---
external help file: Azs.Gallery.Admin-help.xml
Module Name: Azs.Gallery.Admin
online version: 
schema: 2.0.0
---

# Get-AzsGalleryItem

## SYNOPSIS
Lists gallery items.

## SYNTAX

### GalleryItems_List (Default)
```
Get-AzsGalleryItem [<CommonParameters>]
```

### GalleryItems_Get
```
Get-AzsGalleryItem [-Name] <String> [<CommonParameters>]
```

## DESCRIPTION
Get a list of gallery items available in Azure Stack Marketplace

## EXAMPLES

### EXAMPLE 1
```
# List gallery items.
```

Get-AzsGalleryItem

### EXAMPLE 2
```
# Get a gallery item by name.
```

Get-AzsGalleryItem -GalleryItemName 'microsoft.vmss.1.3.6'

## PARAMETERS

### -Name
Identity of the gallery item.
Includes publisher name, item name, and may include version separated by period character.

```yaml
Type: String
Parameter Sets: GalleryItems_Get
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Microsoft.AzureStack.Management.Gallery.Admin.Models.GalleryItem

## NOTES

## RELATED LINKS

