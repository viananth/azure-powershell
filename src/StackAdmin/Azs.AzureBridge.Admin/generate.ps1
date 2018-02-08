
$rpName = "azurebridge"
$location = pwd
$moduleName = "AzureBridge"
$namespace = "Microsoft.AzureStack.Management.AzureBridge.Admin"
$dll = "$namespace.dll"
$client = "$namespace.AzureBridgeAdminClient"
. ..\..\..\tools\GeneratePSSwagger.ps1 -RPName $rpName -Location $location -Name $moduleName -Admin -Repo "bganapa" -Branch "stack-admin" -DLLName $dll -ClientName "$client" -PSSwaggerLocation "D:\github\PSswagger" -AzureStack