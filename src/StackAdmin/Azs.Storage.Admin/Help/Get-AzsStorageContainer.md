---
external help file: Azs.Storage.Admin-help.xml
Module Name: Azs.Storage.Admin
online version:
schema: 2.0.0
---

# Get-AzsStorageContainer

## SYNOPSIS
Returns the list of containers which can be migrated in the specified share.

## SYNTAX

```
Get-AzsStorageContainer -StartIndex <Int32> [-ResourceGroupName <String>] -ShareName <String>
 -FarmName <String> -MaxCount <Int32>
```

## DESCRIPTION
Returns the list of containers which can be migrated in the specified share.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Get-AzsStorageContainer -ResourceGroupName "system.local" -FarmName f9b8e2e2-e4b4-44e0-9d92-6a848b1a5376 -ShareName "||SU1FileServer.azurestack.local|SU1_ObjStore" -StartIndex 0 -MaxCount 10
```

Accountname       Containername     Sharename         ContainerState    UsedBytesInPrimar
																		yVolume
-----------       -------------     ---------         --------------    -----------------
srphealthaccount  azurestackheal...
\\\\SU1FileServe...
Active            27815936
srphealthaccount  azurestackheal...
\\\\SU1FileServe...
Active            24264704
frphealthaccount  azurestackheal...
\\\\SU1FileServe...
Active            10289152
srphealthaccount  azurestackheal...
\\\\SU1FileServe...
Active            6680576
srphealthaccount  azurestackheal...
\\\\SU1FileServe...
Active            6283264
hrphealthaccount  azurestackheal...
\\\\SU1FileServe...
Active            5160960
srphealthaccount  storagemetrics...
\\\\SU1FileServe...
Active            4390912
srphealthaccount  storagemetrics...
\\\\SU1FileServe...
Active            4378624
srphealthaccount  azurestackheal...
\\\\SU1FileServe...
Active            2760704
frphealthaccount  azurestackheal...
\\\\SU1FileServe...
Active            2260992

## PARAMETERS

### -FarmName
Farm Id.

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

### -MaxCount
The max count of containers.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -ResourceGroupName
Resource group name.

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

### -ShareName
Share name which holds the storage containers.

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

### -StartIndex
The start index of get containers.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

