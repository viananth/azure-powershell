---
external help file: Azs.Gallery.Admin-help.xml
Module Name: Azs.Gallery.Admin
online version:
schema: 2.0.0
---

# New-AzsGalleryItem

## SYNOPSIS
Uploads a provider gallery item to the storage.

## SYNTAX

```
New-AzsGalleryItem [-GalleryItemUri] <String>
```

## DESCRIPTION
Uploads a provider gallery item to the storage.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\> New-AzsGalleryItem -GalleryItemUri 'http://galleryitemuri'
```

Create a new gallery item.


## PARAMETERS

### -GalleryItemUri
The URI to the gallery item JSON file.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

### Microsoft.AzureStack.Management.Gallery.Admin.Models.GalleryItem

## NOTES

## RELATED LINKS

