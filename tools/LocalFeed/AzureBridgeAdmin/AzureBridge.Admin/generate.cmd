::
:: Microsoft Azure SDK for Net - Generate library code
:: Copyright (C) Microsoft Corporation. All Rights Reserved.
::

@echo off
call %~dp0..\..\..\..\tools\generate.cmd azsadmin/resource-manager/commerce latest Azure current azure-rest-api-specs %CD%
move AzureBridge\AzureBridge.Admin\Generated .
rd AzureBridge /S /Q